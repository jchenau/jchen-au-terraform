resource "google_dns_record_set" "argocd_a" {
  name         = "argocd.${var.network_dns_name}"
  managed_zone = var.network_dns_zone_name
  project      = var.network_project_id
  type         = "A"
  ttl          = 60

  rrdatas = [
    "34.151.72.213",
  ]
}
