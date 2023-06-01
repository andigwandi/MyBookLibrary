
variable "env_config" {
  type = object({
    admin_access_group       = string
    env                      = string
    app_prefix               = string
    function_storage         = number
    instance                 = string
    kv_abbr                  = string
    kv_access_groups         = list(string)
    location                 = string
    region                   = string
    resource_group           = string
    storage_replication_type = string
    subscription_id          = string
    tags                     = map(string)
  })
}

variable "keyvault_config" {
  type = object({
    enabled_for_deployment          = bool
    enabled_for_disk_encryption     = bool
    enabled_for_template_deployment = bool
    enable_rbac_authorization       = bool
    purge_protection_enabled        = bool
    soft_delete_retention_days      = number
    sku_name                        = string
  })
}

variable "function_code" {
  type        = string
  description = "function app code"
}

variable "keyvault_network_config" {
  type = object({
    private_networking_enabled = bool
    acls_bypass                = string
    default_action             = string
  })
}

variable "vnet_config" {
  type = object({
    name = string
    id   = string
  })
}

variable "subnet_web_config" {
  type = object({
    name = string
    id   = string
  })
}

variable "subnet_app_config" {
  type = object({
    name = string
    id   = string
  })
}

variable "subnet_db_config" {
  type = object({
    name = string
    id   = string
  })
}

variable "sql_credentials" {
  type = object({
    administrator_login    = string
    administrator_password = string
  })
  sensitive = true
}
variable "database_config" {
  type = object({
    primary_database         = string
    primary_database_version = string
  })
}

variable "service_plan_config" {
  type = object({
    app_name                     = string
    maximum_elastic_worker_count = number
    os_type                      = string
    per_site_scaling             = bool
    sku_name                     = string
    worker_count                 = number
  })
}

variable "storage_config" {
  type = object({
    account_kind              = string
    account_replication_type  = string
    account_tier              = string
    containers                = list(any)
    cors_allowed_headers      = list(string)
    cors_allowed_methods      = list(string)
    cors_allowed_origins      = list(string)
    cors_exposed_headers      = list(string)
    cors_max_age_in_seconds   = number
    enable_ttl                = bool
    hierarchical_namespace    = bool
    shared_access_key_enabled = string
    storage_account_name      = string
  })
}

variable "function_config" {
  type = object({
    always_on                        = bool
    app_scale_limit                  = number
    cors                             = list(string)
    daily_memory_time_quota          = number
    ftps_state                       = string
    function_app_edit_mode           = string
    functions_extension_version      = string
    functions_worker_process_count   = string
    functions_worker_runtime         = string
    http2_enabled                    = bool
    https_only                       = bool
    runtime_scale_monitoring_enabled = bool
    use_32_bit_worker                = bool
  })
}
