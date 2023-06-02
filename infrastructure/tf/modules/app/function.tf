module "mbl_function_app" {
  source = "../shared/function_app/windows"
  depends_on = [
    module.sql_server,
    module.code_storage,
    module.keyvault
  ]

  service_plan_config = local.service_plan_config

  code_config = {
    connection_string  = module.code_storage.storage_config.connection_string
    id                 = module.code_storage.storage_config.id
    name               = module.code_storage.storage_config.name
    primary_access_key = module.code_storage.storage_config.primary_access_key
  }

  env_config     = local.env_config
  storage_config = local.storage_config

  keyvault_config = {
    id   = module.keyvault.keyvault_config.id
    name = module.keyvault.keyvault_config.name
  }

  config = {
    app_name                    = "mbl"
    daily_memory_time_quota     = local.function_config.daily_memory_time_quota
    function_app_code           = local.function_code
    https_only                  = local.function_config.https_only
    keyvault_write              = false
    queues                      = []
    functions_extension_version = local.function_config.functions_extension_version
  }

  site_config = {
    always_on                        = local.function_config.always_on
    app_scale_limit                  = 10
    cors                             = local.function_config.cors
    ftps_state                       = local.function_config.ftps_state
    http2_enabled                    = local.function_config.http2_enabled
    runtime_scale_monitoring_enabled = false
    use_32_bit_worker                = local.function_config.use_32_bit_worker
  }

  function_settings = {
    FUNCTION_APP_EDIT_MODE         = local.function_config.function_app_edit_mode
    FUNCTIONS_EXTENSION_VERSION    = local.function_config.functions_extension_version
    FUNCTIONS_WORKER_PROCESS_COUNT = local.function_config.functions_worker_process_count
    FUNCTIONS_WORKER_RUNTIME       = local.function_config.functions_worker_runtime
    https_only                     = true
    REGION                         = local.env_config.region
    RING                           = local.env_config.env
  }

  function_app_network_config = {
    private_networking_enabled = true
    subnet_id                  = null
  }
}
