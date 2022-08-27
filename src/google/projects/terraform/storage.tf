resource "google_storage_bucket" "terraform_state" {
  name          = "jchen-au-terraform-state"
  location      = var.region

  uniform_bucket_level_access = true
}
