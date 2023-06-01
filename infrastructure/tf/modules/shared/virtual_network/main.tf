locals {
  env_config = var.env_config
  config     = var.config
  vnet_name  = "vnet-${local.env_config.env}"
}
resource "azurerm_virtual_network" "main" {
  name                = local.vnet_name
  resource_group_name = local.env_config.resource_group
  location            = local.env_config.location
  address_space       = [local.config.vnet_cidr]

  tags = merge(local.env_config.tags,
    {
      "Name"     = local.vnet_name
      "Function" = "Network"
  })
}
