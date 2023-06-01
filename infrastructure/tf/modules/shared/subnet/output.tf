output "config" {
  value = {
    id   = azurerm_subnet.main.id
    name = azurerm_subnet.main.name
  }
}
