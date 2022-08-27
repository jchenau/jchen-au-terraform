variable "org_id" {
  type    = string
  default = "696719866582"
}

variable "project_id" {
  type = string
}

variable "project_name" {
  type = string
}

variable "region" {
  type    = string
  default = "australia-southeast1"
}

variable "zone" {
  type    = string
  default = "australia-southeast1-c"
}

variable "enabled_apis" {
  type = list(string)
}

terraform {
  backend "gcs" {
    bucket = "jchen-au-terraform-state"
    prefix = "google/projects/terraform"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

data "google_billing_account" "main" {
  display_name = "My Billing Account"
  open         = true
}

resource "google_project" "main" {
  name       = var.project_name
  project_id = var.project_id
  org_id     = var.org_id

  billing_account = data.google_billing_account.main.id
}

resource "google_project_service" "this" {
  for_each = toset(var.enabled_apis)

  project = var.project_id
  service = each.key
}
