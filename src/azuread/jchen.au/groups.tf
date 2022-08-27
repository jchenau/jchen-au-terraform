locals {
  users_data  = [for member in flatten(values(var.groups)) : trimprefix(member, "user:") if can(regex("^user:", member))]
  groups_data = [for member in flatten(values(var.groups)) : trimprefix(member, "group:") if can(regex("^group:", member))]

  groups = {
    for group_name, members in var.groups : group_name => [for member in members : can(regex("^user:", member)) ? data.azuread_user.this[trimprefix(member, "user:")].id : data.azuread_group.this[trimprefix(member, "group:")].id]
  }
}

data "azuread_user" "this" {
  for_each = toset(local.users_data)

  user_principal_name = each.key
}

data "azuread_group" "this" {
  for_each = toset(local.groups_data)

  display_name     = each.key
  security_enabled = true
}

resource "azuread_group" "this" {
  for_each = local.groups

  display_name     = each.key
  security_enabled = true
  members          = each.value
}
