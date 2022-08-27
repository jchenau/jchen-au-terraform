data "google_compute_subnetwork" "kubernetes_node" {
  project = "network-1050"
  name    = "kubernetes-node"
  region  = var.region
}

resource "google_container_cluster" "main" {
  name     = "jchen-au-gke-main"
  location = var.region

  enable_autopilot = true

  network    = data.google_compute_subnetwork.kubernetes_node.network
  subnetwork = data.google_compute_subnetwork.kubernetes_node.self_link

  ip_allocation_policy {
    cluster_secondary_range_name  = "kubernetes-pod"
    services_secondary_range_name = "kubernetes-service"
  }

  authenticator_groups_config {
    security_group = "gke-security-groups@groups.jchen.au"
  }
}
