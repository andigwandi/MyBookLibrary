locals {
  env_config              = var.env_config
  keyvault_config         = var.keyvault_config
  keyvault_network_config = var.keyvault_config

  vnet_config       = var.vnet_config
  subnet_app_config = var.subnet_app_config
  subnet_web_config = var.subnet_web_config
  subnet_db_config  = var.subnet_db_config

  sql_credentials     = var.sql_credentials
  database_config     = var.database_config
  service_plan_config = var.service_plan_config
  storage_config      = var.storage_config
  function_config     = var.function_config
  function_code       = var.function_code
}
