terraform {
  required_version = ">=1.5.0"
  required_providers {
    google = {
        source = "hashicorp/google"
        version = "4.80.0"
    }
  }
}

provider "google" {
  project     = var.project_id
  region      = "us-central1"
}

resource "google_compute_network" "vpc_network" {
  project                 = var.project_id
  name                    = "custom-vpc"
  auto_create_subnetworks = false
  mtu                     = 1460
}


import {
    to = google_compute_network.default
    id = "projects/playground-s-11-f1e6f897/global/networks/default"
}

import {
    to = google_container_cluster.console-cluster
    id = "projects/playground-s-11-f1e6f897/locations/us-central1/clusters/console-release-channel"
}

resource "google_compute_subnetwork" "subnetwork-internal-ipv6" {
  name          = "${var.subnet_name_list[count.index]}-subnet"

  count = length(var.subnet_name_list)

  ip_cidr_range = var.subnet_cidr_list[count.index]
  region        = var.subnet_name_list[count.index]

  stack_type       = "IPV4_ONLY"

  network       = google_compute_network.vpc_network.id
}