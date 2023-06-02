output "function_config" {
  value = {
    id                    = azurerm_windows_function_app.function.id
    name                  = azurerm_windows_function_app.function.name
    outbound_ip_addresses = azurerm_windows_function_app.function.outbound_ip_addresses
    short_name            = local.config.app_name
    storage_config        = local.env_config.function_storage == 1 ? module.function_storage[0].storage_config : local.code_config
  }
}
