output "storage_config" {
  value = {
    name               = azurerm_storage_account.storage.name
    primary_access_key = azurerm_storage_account.storage.primary_access_key
    id                 = azurerm_storage_account.storage.id
    connection_string  = azurerm_storage_account.storage.primary_connection_string
  }
}
