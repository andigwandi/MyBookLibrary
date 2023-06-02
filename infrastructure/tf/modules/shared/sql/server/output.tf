output "config" {
  value = {
    id      = azurerm_mssql_server.main.id
    fqdn    = azurerm_mssql_server.main.fully_qualified_domain_name
    db_name = local.db_config.db_name
  }
}
