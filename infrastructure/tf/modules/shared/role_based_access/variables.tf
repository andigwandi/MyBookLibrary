variable "scope" {
  type = string
}

variable "principal_id" {
  type = string
}

variable "roles" {
  type        = list(string)
  description = "list of role names"
}
