data "google_billing_account" "main" {
  display_name = "My Billing Account"
  open         = true
}

resource "google_project" "terraform" {
  name       = "terraform"
  project_id = var.project_id
  org_id     = var.org_id

  billing_account = data.google_billing_account.main.id
}

resource "google_project_service" "this" {
  for_each = toset(var.enabled_apis)

  project = var.project_id
  service = each.key
}
