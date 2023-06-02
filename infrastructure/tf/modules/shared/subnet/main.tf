locals {
  env_config = var.env_config
  config     = var.config
}
resource "azurerm_subnet" "main" {
  name                 = local.config.name
  resource_group_name  = local.env_config.resource_group
  virtual_network_name = local.config.vnet_name
  address_prefixes     = [local.config.subnet_cidr]
  service_endpoints    = local.config.service_endpoints

  # dynamic "delegation" {
  #   for_each = var.subnet_delegations
  #   content {
  #     name = delegation.key
  #     service_delegation {
  #       name    = delegation.value
  #       actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
  #     }
  #   }
  # }
}
