terraform {
  backend "gcs" {
    bucket = "jchen-au-terraform-state"
    prefix = "azuread/jchen.au"
  }
}

provider "azuread" {
  tenant_id = var.tenant_id
}
