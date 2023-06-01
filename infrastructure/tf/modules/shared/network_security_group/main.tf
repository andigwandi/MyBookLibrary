locals {
  env_config     = var.env_config
  config         = var.config
  security_rules = var.security_rules
}

resource "azurerm_network_security_group" "main" {
  name                = local.config.name
  location            = local.env_config.location
  resource_group_name = local.env_config.resource_group

  dynamic "security_rule" {
    for_each = local.security_rules
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_address_prefix      = security_rule.value.source_address_prefix
      source_port_range          = security_rule.value.source_port_range
      destination_address_prefix = security_rule.value.destination_address_prefix
      destination_port_range     = security_rule.value.destination_port_range
    }
  }

  tags = merge(local.env_config.tags,
    {
      "Name"     = local.config.name
      "Function" = "Network"
  })
}

resource "azurerm_subnet_network_security_group_association" "main" {
  subnet_id                 = local.config.subnet_id
  network_security_group_id = azurerm_network_security_group.main.id
}

