module "compute" {
  source = "../shared/compute"

  env_config = var.env_config
  subnet_config = {
    web_subnet_id = local.subnet_web_config.id
    app_subnet_id = local.subnet_app_config.id
  }

  compute_credentials = {
    admin_username = local.sql_credentials.administrator_login
    admin_password = local.sql_credentials.administrator_password
  }
}
