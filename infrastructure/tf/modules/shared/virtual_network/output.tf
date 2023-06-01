output "config" {
  value = {
    id   = azurerm_virtual_network.main.id
    name = azurerm_virtual_network.main.name
  }
}
