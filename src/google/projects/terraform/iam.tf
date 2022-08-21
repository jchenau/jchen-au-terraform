# test
resource "google_service_account" "terraform" {
  account_id   = "terraform"
}

resource "google_iam_workload_identity_pool" "github" {
  workload_identity_pool_id = "github-pool"
  display_name              = "Github Pool"
}

resource "google_iam_workload_identity_pool_provider" "github" {
  workload_identity_pool_id          = google_iam_workload_identity_pool.github.workload_identity_pool_id
  workload_identity_pool_provider_id = "github"
  attribute_mapping = {
    "google.subject"       = "assertion.sub"
    "attribute.actor"      = "assertion.actor"
    "attribute.aud"        = "assertion.aud"
    "attribute.repository" = "assertion.repository"
  }
  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }
}

data "google_iam_policy" "terraform" {
  binding {
    role = "roles/iam.workloadIdentityUser"

    members = [
      "principalSet://iam.googleapis.com/projects/${google_project.terraform.number}/locations/global/workloadIdentityPools/${google_iam_workload_identity_pool.github.workload_identity_pool_id}/attribute.repository/jchenship/jchen-au-terraform",
    ]
  }

  binding {
    role = "roles/iam.serviceAccountTokenCreator"

    members = [
      "user:junrui.chen@jchen.au",
    ]
  }
}

resource "google_service_account_iam_policy" "terraform" {
  service_account_id = google_service_account.terraform.name
  policy_data        = data.google_iam_policy.terraform.policy_data
}
