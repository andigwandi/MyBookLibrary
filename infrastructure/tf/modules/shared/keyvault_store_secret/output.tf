output "secret_config" {
  value = {
    id      = azurerm_key_vault_secret.secret.id
    version = azurerm_key_vault_secret.secret.version
  }
}
