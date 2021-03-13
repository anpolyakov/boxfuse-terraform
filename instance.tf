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

resource "google_storage_bucket" "app-storage" {
  name = "${var.bucket_name}"
  force_destroy = true
}

resource "google_compute_instance" "maven" {
    count = "${var.num_nodes}"
    name = "${var.maven_instance_name}${count.index + 1}"
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

    provisioner "file" {
      source = "credentials.json"
      destination = "/tmp/credentials.json"

      connection {
        type = "ssh"
        user = "${var.gce_ssh_user}"
        private_key = "${file(var.gce_ssh_private_key_file)}"
        host = "${google_compute_instance.maven[0].network_interface.0.access_config.0.nat_ip}"
      }
    }

    metadata = {
      ssh-keys = "${var.gce_ssh_user}:${file(var.gce_ssh_pub_key_file)}"
    }

    metadata_startup_script = data.template_file.build.rendered
}

data "template_file" "build" {
  template = "${file("${path.module}/templates/build_java_app.tpl")}"

  vars = {
    bucket_name = "lesson14-app-storage"
  }
}

resource "google_compute_instance" "tomcat" {
    count = "${var.num_nodes}"
    name = "${var.tomcat_instance_name}${count.index + 1}"
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

    provisioner "file" {
      source = "credentials.json"
      destination = "/tmp/credentials.json"

      connection {
        type = "ssh"
        user = "${var.gce_ssh_user}"
        private_key = "${file(var.gce_ssh_private_key_file)}"
        host = "${google_compute_instance.tomcat[0].network_interface.0.access_config.0.nat_ip}"
      }
    }

    metadata = {
      ssh-keys = "${var.gce_ssh_user}:${file(var.gce_ssh_pub_key_file)}"
    }

    metadata_startup_script = data.template_file.deploy.rendered
}

data "template_file" "deploy" {
  template = "${file("${path.module}/templates/deploy_java_app.tpl")}"
}