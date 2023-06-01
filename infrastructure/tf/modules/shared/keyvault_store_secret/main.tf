locals {
  keyvault_config = var.keyvault_config
  secret_name     = var.secret_name
  secret_value    = var.secret_value
}

resource "azurerm_key_vault_secret" "secret" {
  name         = local.secret_name
  value        = local.secret_value
  key_vault_id = local.keyvault_config.id
}