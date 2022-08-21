terraform {
  backend "gcs" {
    bucket = "jchen-au-terraform-state"
    prefix = "google/projects/terraform"
  }
}

provider "google" {
  project = var.project_id
  region  = var.location
}
