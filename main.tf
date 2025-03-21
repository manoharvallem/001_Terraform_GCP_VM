provider "google" {
  credentials = file(var.credentials_file)
  project     = var.project_id
  region      = var.region
}

resource "google_compute_instance" "vm_instance" {
  name         = "my-terraform-instance"
  machine_type = "e2-medium"
  zone         = "${var.region}-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"

    access_config {
      # This is required for external IP
    }
  }

  tags = ["web", "dev"]
}

variable "project_id" {}
variable "region" {
  default = "us-central1"
}
variable "credentials_file" {
  default = "~/terraform-key.json"
}

