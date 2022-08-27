resource "google_compute_network" "main" {
  name = "main"

  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "kubernetes_node" {
  name          = "kubernetes-node"
  ip_cidr_range = "10.42.4.0/24"
  region        = var.region
  network       = google_compute_network.main.id

  secondary_ip_range {
    range_name    = "kubernetes-pod"
    ip_cidr_range = "10.200.0.0/16"
  }

  secondary_ip_range {
    range_name    = "kubernetes-service"
    ip_cidr_range = "10.42.0.0/22"
  }
}

resource "google_compute_shared_vpc_host_project" "main" {
  project = var.project_id
}
