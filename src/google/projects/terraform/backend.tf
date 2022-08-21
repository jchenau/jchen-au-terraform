terraform {
  backend "gcs" {
    bucket = "jchen-au-terraform-state"
    prefix = "google/projects/terraform"

    impersonate_service_account = "terraform@terraform-360104.iam.gserviceaccount.com"
  }
}
