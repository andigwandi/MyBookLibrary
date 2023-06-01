variable "config" {
  type = object({
    certificate_permissions = list(string)
    key_permissions         = list(string)
    key_vault_id            = string
    object_id               = string
    secret_permissions      = list(string)
    storage_permissions     = list(string)
    tenant_id               = string
  })
}
