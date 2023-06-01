locals {
  env_config   = var.env_config
  network_cidr = var.network_cidr
}

module "vnet" {
  source = "../shared/virtual_network"

  env_config = local.env_config
  config = {
    vnet_cidr = local.network_cidr.vnetcidr
  }
}

module "subnet_web" {
  source = "../shared/subnet"

  depends_on = [module.vnet]

  env_config = local.env_config

  config = {
    name              = "web-subnet"
    vnet_name         = module.vnet.config.name
    subnet_cidr       = local.network_cidr.websubnetcidr
    service_endpoints = ["Microsoft.KeyVault", "Microsoft.Storage", "Microsoft.Sql", "Microsoft.Web"]
    delegates         = null
  }
}

module "subnet_app" {
  source = "../shared/subnet"

  depends_on = [module.vnet]
  env_config = local.env_config

  config = {
    name              = "app-subnet"
    vnet_name         = module.vnet.config.name
    subnet_cidr       = local.network_cidr.appsubnetcidr
    service_endpoints = ["Microsoft.KeyVault", "Microsoft.Storage", "Microsoft.Sql", "Microsoft.Web"]

    delegates = "Microsoft.Web/serverFarms"
  }
}

module "subnet_db" {
  source = "../shared/subnet"

  depends_on = [module.vnet]
  env_config = local.env_config

  config = {
    name              = "db-subnet"
    vnet_name         = module.vnet.config.name
    subnet_cidr       = local.network_cidr.dbsubnetcidr
    service_endpoints = ["Microsoft.KeyVault", "Microsoft.Storage", "Microsoft.Sql", "Microsoft.Web"]
    delegates         = null
  }
}
