# test
resource "google_organization_iam_policy" "organization" {
  org_id      = var.org_id
  policy_data = data.google_iam_policy.organization.policy_data
}

data "google_iam_policy" "organization" {
  binding {
    role = "roles/billing.admin"

    members = [
      "group:gcp-billing-admin@groups.jchen.au",
    ]
  }

  binding {
    role = "roles/billing.user"

    members = [
      "group:gcp-organization-admin@groups.jchen.au",
      "serviceAccount:terraform@terraform-360104.iam.gserviceaccount.com",
    ]
  }

  binding {
    role = "roles/resourcemanager.organizationViewer"

    members = [
      "group:gcp-billing-admin@groups.jchen.au",
    ]
  }

  binding {
    role = "roles/resourcemanager.organizationAdmin"

    members = [
      "group:gcp-organization-admin@groups.jchen.au",
      "serviceAccount:terraform@terraform-360104.iam.gserviceaccount.com",
    ]
  }

  binding {
    role = "roles/owner"

    members = [
      "group:gcp-organization-admin@groups.jchen.au",
      "serviceAccount:terraform@terraform-360104.iam.gserviceaccount.com",
    ]
  }

  binding {
    role = "roles/viewer"

    members = [
      "domain:jchen.au",
    ]
  }
}