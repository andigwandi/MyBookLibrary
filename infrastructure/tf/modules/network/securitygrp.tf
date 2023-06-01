
module "web-nsg" {
  source = "../shared/network_security_group"

  env_config = local.env_config
  config = {
    name      = "web-nsg"
    subnet_id = module.subnet_web.config.id
  }

  security_rules = [
    {
      name                       = "ssh-rule-1"
      priority                   = 101
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_address_prefix      = "*"
      source_port_range          = "*"
      destination_address_prefix = "*"
      destination_port_range     = "22"
    },
    {
      name                       = "ssh-rule-2"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Deny"
      protocol                   = "Tcp"
      source_address_prefix      = local.network_cidr.dbsubnetcidr
      source_port_range          = "*"
      destination_address_prefix = "*"
      destination_port_range     = "22"
    }
  ]

}


module "app-nsg" {
  source = "../shared/network_security_group"

  env_config = local.env_config
  config = {
    name      = "app-nsg"
    subnet_id = module.subnet_app.config.id
  }

  security_rules = [{
    name                       = "ssh-rule-1"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_address_prefix      = local.network_cidr.websubnetcidr
    source_port_range          = "*"
    destination_address_prefix = "*"
    destination_port_range     = "22"
    },
    {
      name                       = "ssh-rule-2"
      priority                   = 101
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_address_prefix      = local.network_cidr.websubnetcidr
      source_port_range          = "*"
      destination_address_prefix = "*"
      destination_port_range     = "22"
    }
  ]
}


module "db-nsg" {
  source = "../shared/network_security_group"

  env_config = local.env_config
  config = {
    name      = "db-nsg"
    subnet_id = module.subnet_db.config.id
  }

  security_rules = [{
    name                       = "ssh-rule-1"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_address_prefix      = local.network_cidr.appsubnetcidr
    source_port_range          = "*"
    destination_address_prefix = "*"
    destination_port_range     = "3306"
    },
    {
      name                       = "ssh-rule-2"
      priority                   = 102
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_address_prefix      = local.network_cidr.appsubnetcidr
      source_port_range          = "*"
      destination_address_prefix = "*"
      destination_port_range     = "3306"
    },
    {
      name                       = "ssh-rule-3"
      priority                   = 100
      direction                  = "Outbound"
      access                     = "Deny"
      protocol                   = "Tcp"
      source_address_prefix      = local.network_cidr.websubnetcidr
      source_port_range          = "*"
      destination_address_prefix = "*"
      destination_port_range     = "3306"
    }
  ]
}
