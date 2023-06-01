variable "env_config" {
  type = object({
    admin_access_group       = string
    env                      = string
    app_prefix               = string
    function_storage         = number
    instance                 = string
    kv_abbr                  = string
    kv_access_groups         = list(string)
    location                 = string
    region                   = string
    resource_group           = string
    storage_replication_type = string
    subscription_id          = string
    tags                     = map(string)
  })
}

variable "config" {
  type = object({
    enabled_for_deployment          = bool
    enabled_for_disk_encryption     = bool
    enabled_for_template_deployment = bool
    enable_rbac_authorization       = bool
    purge_protection_enabled        = bool
    soft_delete_retention_days      = number
    sku_name                        = string
  })
}

variable "keyvault_network_config" {
  type = object({
    acls_bypass                = string
    default_action             = string
    private_networking_enabled = bool
    subnet_ids                 = list(any)
  })
}
