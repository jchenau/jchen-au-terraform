resource "google_service_account" "kubernetes_node" {
  account_id = "kubernetes-node"
}

locals {
  kubernetes_workload_identities = {
    cert-manager = [
      "cert-manager/cert-manager",
    ]
    external-dns = [
      "external-dns/external-dns",
    ]
  }
}

resource "google_service_account" "kubernetes_workload_identity" {
  for_each = local.kubernetes_workload_identities

  account_id = each.key
}

data "google_iam_policy" "kubernetes_workload_identity" {
  for_each = local.kubernetes_workload_identities

  binding {
    role = "roles/iam.workloadIdentityUser"

    members = [
      for kubernetes_service_account in each.value :
      "serviceAccount:${var.project_id}.svc.id.goog[${kubernetes_service_account}]"
    ]
  }
}

resource "google_service_account_iam_policy" "kubernetes_workload_identity" {
  for_each = local.kubernetes_workload_identities

  service_account_id = google_service_account.kubernetes_workload_identity[each.key].name
  policy_data        = data.google_iam_policy.kubernetes_workload_identity[each.key].policy_data
}
