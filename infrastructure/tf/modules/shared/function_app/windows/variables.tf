variable "env_config" {
  type = object({
    admin_access_group = string
    app_prefix         = string
    env                = string
    function_storage   = number
    instance           = string
    location           = string
    resource_group     = string
    tags               = map(string)
  })
}

variable "storage_config" {
  type = object({
    account_kind              = string
    account_replication_type  = string
    account_tier              = string
    containers                = list(any)
    cors_allowed_headers      = list(string)
    cors_allowed_methods      = list(string)
    cors_allowed_origins      = list(string)
    cors_exposed_headers      = list(string)
    cors_max_age_in_seconds   = number
    enable_ttl                = bool
    hierarchical_namespace    = bool
    shared_access_key_enabled = string
    storage_account_name      = string
  })
}

variable "config" {
  type = object({
    app_name                    = string
    daily_memory_time_quota     = number
    function_app_code           = string
    https_only                  = bool
    keyvault_write              = bool
    queues                      = list(string)
    functions_extension_version = string
  })
}

variable "function_settings" {
  type = map(any)
}

variable "keyvault_config" {
  type = object({
    name = string
    id   = string
  })
}

variable "code_config" {
  type = object({
    connection_string  = string
    id                 = string
    name               = string
    primary_access_key = string
  })
}

variable "site_config" {
  type = object({
    always_on                        = bool
    app_scale_limit                  = number
    cors                             = list(string)
    ftps_state                       = string
    http2_enabled                    = bool
    runtime_scale_monitoring_enabled = bool
    use_32_bit_worker                = bool
  })
}
variable "function_app_network_config" {
  type = object({
    private_networking_enabled = bool
    subnet_id                  = string
  })
}

variable "service_plan_config" {
  type = object({
    maximum_elastic_worker_count = number
    os_type                      = string
    per_site_scaling             = bool
    sku_name                     = string
    worker_count                 = number
  })
}
