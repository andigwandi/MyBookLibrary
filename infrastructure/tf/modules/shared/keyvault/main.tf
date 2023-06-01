locals {
  env_config              = var.env_config
  keyvault_name           = "${local.env_config.app_prefix}-${local.env_config.kv_abbr}-${local.env_config.instance}-${local.env_config.env}"
  config                  = var.config
  keyvault_network_config = var.keyvault_network_config
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "key_vault" {
  depends_on = [
    data.azurerm_client_config.current
  ]

  name                = local.keyvault_name
  location            = local.env_config.location
  resource_group_name = local.env_config.resource_group
  tenant_id           = data.azurerm_client_config.current.tenant_id

  enabled_for_deployment          = local.config.enabled_for_deployment
  enabled_for_disk_encryption     = local.config.enabled_for_disk_encryption
  enabled_for_template_deployment = local.config.enabled_for_template_deployment
  enable_rbac_authorization       = local.config.enable_rbac_authorization
  purge_protection_enabled        = local.config.purge_protection_enabled
  soft_delete_retention_days      = local.config.soft_delete_retention_days
  sku_name                        = local.config.sku_name

  public_network_access_enabled = (local.keyvault_network_config.private_networking_enabled) ? true : null

  dynamic "network_acls" {
    for_each = (local.keyvault_network_config.private_networking_enabled) ? [1] : []
    content {
      bypass                     = local.keyvault_network_config.acls_bypass
      default_action             = local.keyvault_network_config.default_action
      virtual_network_subnet_ids = local.keyvault_network_config.subnet_ids
      ip_rules                   = length(local.keyvault_network_config.allowed_ip_list) == 0 ? [] : local.keyvault_network_config.allowed_ip_list
    }
  }

  tags = merge(local.env_config.tags,
    {
      "Name"     = local.keyvault_name
      "Function" = "Service"
    }
  )

}

resource "azurerm_key_vault_access_policy" "keyvault_pipeline_admin_access" {
  depends_on = [
    azurerm_key_vault.key_vault,
    data.azurerm_client_config.current
  ]
  key_vault_id = azurerm_key_vault.key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  key_permissions = [
    "Backup", "Create", "Decrypt", "Delete", "Encrypt", "Get", "Import", "List", "Purge", "Recover", "Restore", "Sign", "UnwrapKey", "Update", "Verify", "WrapKey"
  ]

  secret_permissions = [
    "Backup", "Delete", "Get", "List", "Purge", "Recover", "Restore", "Set"
  ]

  storage_permissions = [
    "Backup", "Delete", "DeleteSAS", "Get", "GetSAS", "List", "ListSAS", "Purge", "Recover", "RegenerateKey", "Restore", "Set", "SetSAS", "Update"
  ]

  certificate_permissions = [
    "Backup", "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge", "Recover", "Restore", "SetIssuers", "Update"
  ]
}
