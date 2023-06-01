module "keyvault" {
  source = "../shared/keyvault"

  env_config = local.env_config
  config     = local.keyvault_config
  keyvault_network_config = merge(var.keyvault_network_config,
    {
      subnet_ids = [local.subnet_app_config.id]
    }
  )
}
