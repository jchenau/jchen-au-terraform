locals {
  users = flatten(values(var.groups))

  groups = {
    for group_name, members in var.groups : group_name => [for member in members : data.azuread_user.this[member].id]
  }
}

data "azuread_user" "this" {
  for_each = toset(local.users)

  user_principal_name = each.key
}

resource "azuread_group" "this" {
  for_each = local.groups

  display_name     = each.key
  security_enabled = true
  members          = each.value
}
