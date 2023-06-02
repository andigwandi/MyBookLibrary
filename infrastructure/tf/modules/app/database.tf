
module "sql_server" {
  source = "../shared/sql/server"

  env_config = local.env_config
  db_config = {
    server_name               = "mssql"
    db_name                   = "db"
    primary_database_version  = "12.0"
    primary_database_admin    = local.sql_credentials.administrator_login
    primary_database_password = local.sql_credentials.administrator_password
    subnet_id                 = local.subnet_db_config.id
  }
}

module "db_storage_store_secret_connection_string" {
  source = "../shared/keyvault_store_secret"
  depends_on = [
    module.module.sql_server,
    module.keyvault
  ]

  keyvault_config = module.keyvault.keyvault_config
  secret_name     = "db-connection-string"
  secret_value    = format("Server=tcp:%s,1433;Initial Catalog=%s;Persist Security Info=False;User ID=%s;Password=%s;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;", module.sql_server.config.fqdn, module.sql_server.config.db_name, local.sql_credentials.administrator_login, local.sql_credentials.administrator_password)
}
