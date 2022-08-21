terraform {
  backend "gcs" {
    bucket = "jchen-au-terraform-state"
    prefix = "google/organizations/jchen.au"
  }
}

provider "google" {}
