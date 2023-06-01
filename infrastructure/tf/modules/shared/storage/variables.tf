variable "env_config" {
  type = object({
    admin_access_group = string
    app_prefix         = string
    env                = string
    instance           = string
    location           = string
    resource_group     = string
    tags               = map(string)
  })
}

variable "config" {
  type = object({
    account_kind              = string
    account_replication_type  = string
    account_tier              = string
    containers                = list(string)
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

