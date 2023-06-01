locals {
  env_config           = var.env_config
  config               = var.config
  storage_account_name = replace("${local.config.storage_account_name}${local.env_config.instance}${local.env_config.env}", "-", "")
}

resource "azurerm_storage_account" "storage" {
  name                            = local.storage_account_name
  resource_group_name             = local.env_config.resource_group
  location                        = local.env_config.location
  account_tier                    = local.config.account_tier
  account_replication_type        = local.config.account_replication_type
  account_kind                    = local.config.account_kind
  allow_nested_items_to_be_public = false
  enable_https_traffic_only       = true
  shared_access_key_enabled       = local.config.shared_access_key_enabled
  is_hns_enabled                  = local.config.hierarchical_namespace

  tags = merge(local.env_config.tags,
    {
      "Name"     = local.storage_account_name
      "Function" = "Storage"
    }
  )

  blob_properties {
    cors_rule {
      allowed_headers    = local.config.cors_allowed_headers    # ["*"]
      allowed_methods    = local.config.cors_allowed_methods    # ["GET", "HEAD", "POST", "PUT", "DELETE", "MERGE", "OPTIONS", "PATCH"]
      allowed_origins    = local.config.cors_allowed_origins    # ["*"]
      exposed_headers    = local.config.cors_exposed_headers    # ["*"]
      max_age_in_seconds = local.config.cors_max_age_in_seconds # 3600
    }
  }
}

resource "azurerm_storage_container" "ct" {
  depends_on            = [azurerm_storage_account.storage]
  count                 = length(local.config.containers)
  name                  = element(local.config.containers, count.index)
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}

