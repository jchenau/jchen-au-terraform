data "google_compute_subnetwork" "kubernetes_node" {
  project = var.network_project_id
  name    = "kubernetes-node"
  region  = var.region
}

resource "google_container_cluster" "main" {
  name     = "jchen-au-gke-main"
  location = var.region
  node_locations = [
    var.zone,
  ]

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1

  network    = data.google_compute_subnetwork.kubernetes_node.network
  subnetwork = data.google_compute_subnetwork.kubernetes_node.self_link

  ip_allocation_policy {
    cluster_secondary_range_name  = "kubernetes-pod"
    services_secondary_range_name = "kubernetes-service"
  }

  authenticator_groups_config {
    security_group = "gke-security-groups@groups.jchen.au"
  }

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  // disable default logging to reduce resource request
  // should not do this in production
  logging_config {
    enable_components = []
  }

  // disable default monitoring to reduce resource request
  // should not do this in production
  monitoring_config {
    enable_components = []
  }
}

resource "google_container_node_pool" "primary" {
  name       = "primary"
  cluster    = google_container_cluster.main.id
  node_count = 1

  node_config {
    machine_type = "e2-medium"
    preemptible  = true
    disk_size_gb = 20

    service_account = google_service_account.kubernetes_node.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]

    workload_metadata_config {
      mode = "GKE_METADATA"
    }
  }
}
