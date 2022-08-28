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

variable "enable_apis" {
  type    = list(string)
  default = []
}

variable "enable_shared_vpc" {
  type    = bool
  default = false
}

variable "network_project_id" {
  type    = string
  default = "network-1050"
}

variable "network_dns_name" {
  type    = string
  default = "jchen.au."
}

variable "network_dns_zone_name" {
  type    = string
  default = "jchen-au"
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
  for_each = toset(var.enable_apis)

  project = var.project_id
  service = each.key

  depends_on = [
    google_project.main,
  ]
}

resource "google_compute_shared_vpc_service_project" "this" {
  count = var.enable_shared_vpc ? 1 : 0

  host_project    = var.network_project_id
  service_project = var.project_id

  depends_on = [
    google_project.main,
  ]
}
