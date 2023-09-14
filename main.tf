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

# import {
#     to = google_compute_network.default
#     id = "projects/playground-s-11-f1e6f897/global/networks/default"
# }

# import {
#     to = google_container_cluster.console-cluster
#     id = "projects/playground-s-11-f1e6f897/locations/us-central1/clusters/console-release-channel"
# }

module "vpc" {
  source = "./modules/VPC"
  project_id = var.project_id
  vpc_name = var.vpc_name
  mtu = var.mtu
  subnet_cidr_list = var.subnet_cidr_list
  subnet_name_list = var.subnet_name_list
}

module "iam" {
  source = "./modules/IAM"
}

module "gke" {
  source = "./modules/GKE"
  gke-sa = module.iam.gke-sa
}