resource "azuread_application" "argocd" {
  display_name = "argocd"

  group_membership_claims = [
    "SecurityGroup",
  ]

  web {
    redirect_uris = [
      "https://argocd.jchen.au/auth/callback",
    ]
  }

  required_resource_access {
    resource_app_id = "00000003-0000-0000-c000-000000000000" # Microsoft Graph

    resource_access {
      id   = "e1fe6dd8-ba31-4d61-89e7-88639da4683d" # User.Read
      type = "Scope"
    }
  }
}

resource "azuread_application_password" "argocd" {
  application_object_id = azuread_application.argocd.object_id
}
