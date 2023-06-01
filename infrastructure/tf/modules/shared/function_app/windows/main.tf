locals {
  env_config                  = var.env_config
  config                      = var.config
  function_prefix             = local.config.app_name
  function_name               = "${local.function_prefix}-fnap-${local.env_config.instance}-${local.env_config.env}"
  code_container_name         = "code"
  storage_config              = var.storage_config
  storage_account_name        = "${local.env_config.app_prefix}${local.config.app_name}"
  function_settings           = var.function_settings
  code_hash                   = replace(filebase64sha256(local.config.function_app_code), "/", "-")
  code_blob_name              = "${local.function_prefix}-${local.code_hash}.zip"
  keyvault_config             = var.keyvault_config
  site_config                 = var.site_config
  code_config                 = var.code_config
  function_app_network_config = var.function_app_network_config
  plan_name                   = "${local.config.app_name}-svcp-${local.env_config.instance}-${local.env_config.env}"
  service_plan_config         = var.service_plan_config
}

locals {
  read_key_permissions = [
    "Get", "List",
  ]

  read_secret_permissions = [
    "Get", "List",
  ]

  read_storage_permissions = [
    "Get", "List", "GetSAS", "ListSAS"
  ]

  read_certificate_permissions = [
    "Get", "GetIssuers", "List", "ListIssuers"
  ]

  write_key_permissions = [
    "Get", "List", "Backup", "Create", "Decrypt", "Delete", "Encrypt", "Import", "Purge", "Recover", "Restore", "Sign", "UnwrapKey", "Update", "Verify", "WrapKey"
  ]

  write_secret_permissions = [
    "Get", "List", "Backup", "Delete", "Purge", "Recover", "Restore", "Set"
  ]

  write_storage_permissions = [
    "Get", "GetSAS", "List", "ListSAS", "Backup", "Delete", "DeleteSAS", "Purge", "Recover", "RegenerateKey", "Restore", "Set", "SetSAS", "Update"
  ]

  write_certificate_permissions = [
    "Get", "GetIssuers", "List", "ListIssuers", "Backup", "Create", "Delete", "DeleteIssuers", "Import", "ManageContacts", "ManageIssuers", "Purge", "Recover", "Restore", "SetIssuers", "Update"
  ]

  keyvault_access = local.config.keyvault_write == true ? {
    key_permissions         = local.write_key_permissions
    secret_permissions      = local.write_secret_permissions
    storage_permissions     = local.write_storage_permissions
    certificate_permissions = local.write_certificate_permissions
    } : {
    key_permissions         = local.read_key_permissions
    secret_permissions      = local.read_secret_permissions
    storage_permissions     = local.read_storage_permissions
    certificate_permissions = local.read_certificate_permissions
  }
}

resource "azurerm_service_plan" "instance" {
  location                     = local.env_config.location
  maximum_elastic_worker_count = local.service_plan_config.maximum_elastic_worker_count
  name                         = local.plan_name
  os_type                      = local.service_plan_config.os_type
  resource_group_name          = local.env_config.resource_group
  sku_name                     = local.service_plan_config.sku_name
  worker_count                 = local.service_plan_config.worker_count

  tags = merge(local.env_config.tags,
    {
      "Name" = local.plan_name
    }
  )
}


module "function_storage" {
  source = "../../storage"
  count  = local.env_config.function_storage

  env_config = local.env_config
  config = {
    account_tier              = local.storage_config.account_tier
    account_kind              = local.storage_config.account_kind
    account_replication_type  = local.storage_config.account_replication_type
    containers                = [local.code_container_name]
    cors_allowed_headers      = local.storage_config.cors_allowed_headers
    cors_allowed_methods      = local.storage_config.cors_allowed_methods
    cors_allowed_origins      = local.storage_config.cors_allowed_origins
    cors_exposed_headers      = local.storage_config.cors_exposed_headers
    cors_max_age_in_seconds   = local.storage_config.cors_max_age_in_seconds
    enable_ttl                = local.storage_config.enable_ttl
    hierarchical_namespace    = local.storage_config.hierarchical_namespace
    shared_access_key_enabled = local.storage_config.shared_access_key_enabled
    storage_account_name      = local.storage_account_name
  }
}

resource "azurerm_storage_blob" "appcode" {
  name                   = local.code_blob_name
  storage_account_name   = local.code_config.name
  storage_container_name = local.code_container_name
  type                   = "Block"
  source                 = local.config.function_app_code
  access_tier            = "Hot"

  lifecycle {
    create_before_destroy = true
  }
}


resource "azurerm_windows_function_app" "function" {
  depends_on = [
    module.function_storage
  ]

  service_plan_id             = azurerm_service_plan.instance.id
  daily_memory_time_quota     = local.config.daily_memory_time_quota
  https_only                  = local.config.https_only
  location                    = local.env_config.location
  name                        = local.function_name
  resource_group_name         = local.env_config.resource_group
  storage_account_access_key  = local.code_config.primary_access_key
  storage_account_name        = local.code_config.name
  functions_extension_version = local.config.functions_extension_version

  app_settings = merge(
    local.function_settings,
    {
      HASH                     = local.code_hash
      WEBSITE_RUN_FROM_PACKAGE = "${azurerm_storage_blob.appcode.url}"
      AzureWebJobsStorage      = local.code_config.connection_string
      IS_LOCAL                 = "false"
    }
  )

  virtual_network_subnet_id = local.function_app_network_config.subnet_id

  tags = merge(local.env_config.tags,
    {
      "Name"     = local.function_name
      "Function" = "App"
    }
  )


  site_config {
    cors {
      allowed_origins = local.site_config.cors
    }

    always_on                        = false
    app_scale_limit                  = local.site_config.app_scale_limit
    ftps_state                       = local.site_config.ftps_state
    http2_enabled                    = local.site_config.http2_enabled
    pre_warmed_instance_count        = 1
    runtime_scale_monitoring_enabled = local.site_config.runtime_scale_monitoring_enabled
    use_32_bit_worker                = local.site_config.use_32_bit_worker
    elastic_instance_minimum         = 1
  }

  lifecycle {
    create_before_destroy = true
  }
}

data "azurerm_function_app_host_keys" "key" {
  depends_on = [
    azurerm_windows_function_app.function
  ]

  name                = local.function_name
  resource_group_name = local.env_config.resource_group
}

data "azurerm_client_config" "current" {}

module "function_storage_managed_rbac" {
  source = "../../role_based_access"
  depends_on = [
    azurerm_windows_function_app.function,
  ]

  scope        = local.code_config.id
  principal_id = azurerm_windows_function_app.function.identity[0].principal_id

  roles = [
    "Storage Blob Data Contributor",
    "Storage Account Key Operator Service Role",
    "Reader and Data Access",
    "Storage Blob Data Reader",
  ]
}
