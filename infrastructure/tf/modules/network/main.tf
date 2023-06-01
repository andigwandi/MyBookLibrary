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
    name        = "web-subnet"
    vnet_name   = module.vnet.config.name
    subnet_cidr = local.network_cidr.websubnetcidr
  }
}

module "subnet_app" {
  source = "../shared/subnet"

  depends_on = [module.vnet]
  env_config = local.env_config

  config = {
    name        = "app-subnet"
    vnet_name   = module.vnet.config.name
    subnet_cidr = local.network_cidr.appsubnetcidr
  }
}

module "subnet_db" {
  source = "../shared/subnet"

  depends_on = [module.vnet]
  env_config = local.env_config

  config = {
    name        = "db-subnet"
    vnet_name   = module.vnet.config.name
    subnet_cidr = local.network_cidr.dbsubnetcidr
  }
}
