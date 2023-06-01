output "storage_config" {
  value = {
    id   = azurerm_mssql_server.main.id
    fqdn = azurerm_mssql_server.main.fully_qualified_domain_name
  }
}
