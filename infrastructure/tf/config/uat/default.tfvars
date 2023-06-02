env_config = {
  admin_access_group       = "MBL-ADMINS"
  env                      = "uat"
  function_storage         = 0
  instance                 = "01"
  kv_abbr                  = "kvt"
  kv_access_groups         = ["MBL-ADMINS", "mbl-DEV"]
  location                 = "East US"
  region                   = "eastus-1"
  resource_group           = "mbl-uat"
  storage_replication_type = "LRS"
  subscription_id          = "c79a4db8-e628-4a6b-9da6-7e30602a6b73"
}

network_cidr = {
  vnetcidr      = "10.1.0.0/16"
  websubnetcidr = "10.1.1.0/24"
  appsubnetcidr = "10.1.2.0/24"
  dbsubnetcidr  = "10.1.3.0/24"
}


database_config = {
  primary_database         = "sql-primary-database"
  primary_database_version = "12.0"
}


service_plan_config = {
  maximum_elastic_worker_count = null
  os_type                      = "Windows"
  per_site_scaling             = false
  sku_name                     = "B1"
  worker_count                 = 1
  zone_balancing_enabled       = false
}
