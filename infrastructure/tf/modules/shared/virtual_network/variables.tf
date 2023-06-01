
variable "env_config" {
  type = object({
    admin_access_group       = string
    env                      = string
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
    vnet_cidr = string
  })
}
