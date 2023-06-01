module "code_storage" {
  source = "../shared/storage"
  depends_on = [
    module.keyvault
  ]

  env_config = local.env_config
  config     = local.storage_config
}
