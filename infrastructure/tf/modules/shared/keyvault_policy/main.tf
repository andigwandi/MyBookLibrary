locals {
  config = var.config
}

resource "azurerm_key_vault_access_policy" "keyvault_function_access" {
  key_vault_id = local.config.key_vault_id
  tenant_id    = local.config.tenant_id
  object_id    = local.config.object_id

  certificate_permissions = local.config.certificate_permissions
  key_permissions         = local.config.key_permissions
  secret_permissions      = local.config.secret_permissions
  storage_permissions     = local.config.storage_permissions
}
