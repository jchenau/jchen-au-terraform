resource "google_dns_record_set" "main_mx" {
  name         = google_dns_managed_zone.main.dns_name
  managed_zone = google_dns_managed_zone.main.name
  type         = "MX"
  ttl          = 3600

  rrdatas = [
    "5 gmr-smtp-in.l.google.com.",
    "10 alt1.gmr-smtp-in.l.google.com.",
    "20 alt2.gmr-smtp-in.l.google.com.",
    "30 alt3.gmr-smtp-in.l.google.com.",
    "40 alt4.gmr-smtp-in.l.google.com.",
  ]
}

resource "google_dns_record_set" "main_txt" {
  name         = google_dns_managed_zone.main.dns_name
  managed_zone = google_dns_managed_zone.main.name
  type         = "TXT"
  ttl          = 3600

  rrdatas = [
    "\"MS=ms39790162\"",
  ]
}

resource "google_dns_record_set" "groups_txt" {
  name         = "groups.${google_dns_managed_zone.main.dns_name}"
  managed_zone = google_dns_managed_zone.main.name
  type         = "TXT"
  ttl          = 3600

  rrdatas = [
    "\"google-site-verification=E-V1ri5jO9rMhfB9xEySYsvVpBNi6fogCAEsduUiAbA\"",
  ]
}
