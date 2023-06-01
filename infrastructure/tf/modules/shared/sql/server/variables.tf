
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

variable "db_config" {
  type = object({
    server_name               = string
    db_name                   = string
    primary_database_version  = string
    primary_database_admin    = string
    primary_database_password = string
    subnet_id                 = string
  })
}
