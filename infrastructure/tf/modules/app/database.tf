
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
