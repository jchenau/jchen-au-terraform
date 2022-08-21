terraform {
  backend "gcs" {
    bucket  = "jchen-au-terraform-state"
    prefix  = "google/projects/terraform"
  }
}
