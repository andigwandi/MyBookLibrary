locals {
  scope        = var.scope
  principal_id = var.principal_id
  roles        = var.roles
}

resource "azurerm_role_assignment" "contributor" {
  for_each = toset(local.roles)

  role_definition_name = each.value
  scope                = local.scope
  principal_id         = local.principal_id
}
