
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

variable "subnet_config" {
  type = object({
    web_subnet_id = string
    app_subnet_id = string
  })

}

variable "compute_credentials" {
  type = object({
    admin_username = string
    admin_password = string
  })
}
