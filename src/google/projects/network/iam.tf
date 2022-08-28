resource "google_project_iam_policy" "project" {
  project     = var.project_id
  policy_data = data.google_iam_policy.project.policy_data
}

data "google_iam_policy" "project" {
  binding {
    role = "roles/compute.networkUser"
    members = [
      "serviceAccount:503017804102@cloudservices.gserviceaccount.com",
      "serviceAccount:service-503017804102@container-engine-robot.iam.gserviceaccount.com",
    ]
  }

  binding {
    role = "roles/compute.securityAdmin"
    members = [
      "serviceAccount:service-503017804102@container-engine-robot.iam.gserviceaccount.com",
    ]
  }

  binding {
    role = "roles/compute.serviceAgent"
    members = [
      "serviceAccount:service-247725844110@compute-system.iam.gserviceaccount.com",
    ]
  }

  binding {
    role = "roles/container.hostServiceAgentUser"
    members = [
      "serviceAccount:service-503017804102@container-engine-robot.iam.gserviceaccount.com",
    ]
  }

  binding {
    role = "roles/container.serviceAgent"
    members = [
        "serviceAccount:service-247725844110@container-engine-robot.iam.gserviceaccount.com",
    ]
  }

  binding {
    role = "roles/dns.admin"
    members = [
      "serviceAccount:cert-manager@kubernetes-8241.iam.gserviceaccount.com",
      "serviceAccount:external-dns@kubernetes-8241.iam.gserviceaccount.com",
    ]
  }

  binding {
    role = "roles/editor"
    members = [
      "serviceAccount:247725844110-compute@developer.gserviceaccount.com",
      "serviceAccount:247725844110@cloudservices.gserviceaccount.com",
    ]
  }
}
