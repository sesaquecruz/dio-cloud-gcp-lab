terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }

   backend "gcs" {
    bucket  = "spacegamesterraform"
    prefix  = "terraform/state"
  }
  
}

provider "google" {
  project = "spacegames-devops-iac"
  region  = "us-east1"
  zone    = "us-east1-c"
}

resource "google_compute_network" "vpc_network" {
  name = "${var.network_name}"
}

resource "google_compute_instance" "vm_instance" {
  name         = "cloudbuildterraform"
  machine_type = "f1-micro"
  tags = ["prod"]

  labels = {
    east_cost = "${var.east_cost_rh}"
  }

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }
  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }
}
