output "keyvault_config" {
  value = {
    name = azurerm_key_vault.key_vault.name
    id   = azurerm_key_vault.key_vault.id
  }
}
