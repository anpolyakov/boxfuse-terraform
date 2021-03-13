terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.59.0"
    }
  }
}

provider "google" {
  project = "${var.project}"
  region = "${var.region}"
  zone = "${var.zone}"
  credentials = file("credentials.json")
}

resource "google_compute_instance" "default" {
    count = "${var.num_nodes}"
    name = "${var.name}-${count.index + 1}"
    machine_type = "${var.machine_type}"
    min_cpu_platform = "${var.min_cpu_platform}"

    tags = ["http-server", "https-server", "tomcat"]

    boot_disk {
      initialize_params {
        image = "${var.image}"
        size  = "${var.disk_size}"
      }
    }

    network_interface {
        network = "default"

        access_config {
            // Get Public IP
        }
    }

    metadata = {
      ssh-keys = "${var.gce_ssh_user}:${file(var.gce_ssh_pub_key_file)}"
    }

}

resource "google_compute_firewall" "default" {
    name = "devops-firewall"
    network = google_compute_network.default.name
    
    allow {
      protocol = "tcp"
      ports    = ["80", "8080", "443"]
    }

}

resource "google_compute_network" "default" {
    name = "devops-network"
}
