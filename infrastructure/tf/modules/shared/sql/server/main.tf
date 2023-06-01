locals {
  env_config  = var.env_config
  db_config   = var.db_config
  server_name = "${local.env_config.app_prefix}-${var.db_config.server_name}-${local.env_config.env}"
}


resource "azurerm_mssql_server" "main" {
  name                         = local.server_name
  resource_group_name          = local.env_config.resource_group
  location                     = local.env_config.location
  version                      = local.db_config.primary_database_version
  administrator_login          = local.db_config.primary_database_admin
  administrator_login_password = local.db_config.primary_database_password

  public_network_access_enabled = true

  tags = merge(local.env_config.tags,
    {
      "Name"     = local.server_name
      "Function" = "Storage"
    }
  )
}

resource "azurerm_mssql_database" "test" {
  name           = local.db_config.db_name
  server_id      = azurerm_mssql_server.main.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = 4
  read_scale     = true
  sku_name       = "S0"
  zone_redundant = false

  tags = merge(local.env_config.tags,
    {
      "Name"     = local.db_config.db_name
      "Function" = "Storage"
    }
  )
}
