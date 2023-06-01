locals {
  env_config              = var.env_config
  network_cidr            = var.network_cidr
  keyvault_config         = var.keyvault_config
  keyvault_network_config = var.keyvault_network_config
  sql_credentials         = var.sql_credentials
  database_config         = var.database_config
  service_plan_config     = var.service_plan_config
  storage_config          = var.storage_config
  function_config         = var.function_config
  function_code           = var.function_code

  tags = merge(var.tags,
    {
      "Environment" = local.env_config.env
    }
  )
}


module "network" {
  source       = "../modules/network"
  network_cidr = local.network_cidr
  env_config = merge(
    local.env_config,
    {
      app_prefix = "mbl",
      tags       = local.tags
    }
  )
}

module "app" {
  source = "../modules/app"

  keyvault_config         = local.keyvault_config
  keyvault_network_config = var.keyvault_network_config
  vnet_config             = module.network.vnet_config
  subnet_app_config       = module.network.subnet_app_config
  subnet_web_config       = module.network.subnet_web_config
  subnet_db_config        = module.network.subnet_db_config
  sql_credentials         = local.sql_credentials
  database_config         = local.database_config
  service_plan_config     = local.service_plan_config
  storage_config          = local.storage_config
  function_config         = local.function_config
  function_code           = local.function_code
  env_config = merge(
    local.env_config,
    {
      app_prefix = "mbl",
      tags       = local.tags
    }
  )
}
