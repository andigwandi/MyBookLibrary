variable "keyvault_config" {
  type = object({
    id   = string
    name = string
  })
}

variable "secret_name" {
  type = string
}

variable "secret_value" {
  type      = string
  sensitive = true
}
