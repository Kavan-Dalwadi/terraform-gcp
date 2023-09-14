resource "google_container_cluster" "primary" {
  name     = "my-gke-cluster"
  location = "us-central1"

  initial_node_count       = 1
  remove_default_node_pool = true
  node_locations           = ["us-central1-a", "us-central1-c", "us-central1-f"]
  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  addons_config {
    dns_cache_config {
      enabled = false
    }
    gce_persistent_disk_csi_driver_config {
      enabled = true
    }
    horizontal_pod_autoscaling {
      disabled = false
    }
    http_load_balancing {
      disabled = false
    }
    network_policy_config {
      disabled = true
    }
  }

  ip_allocation_policy {
    cluster_ipv4_cidr_block       = "10.4.0.0/14"
    services_ipv4_cidr_block      = "10.8.0.0/20"
    stack_type                    = "IPV4"
    pod_cidr_overprovision_config {
      disabled = false
    }
  }

  logging_config {
    enable_components = ["SYSTEM_COMPONENTS", "WORKLOADS"]
  }

  monitoring_config {
    enable_components = ["SYSTEM_COMPONENTS"]
    advanced_datapath_observability_config {
      enable_metrics = false
      relay_mode     = "DISABLED"
    }
    managed_prometheus {
      enabled = true
    }
  }

  private_cluster_config {
    enable_private_endpoint     = false
    enable_private_nodes        = false
    master_ipv4_cidr_block      = null
    private_endpoint_subnetwork = null
    master_global_access_config {
      enabled = false
    }
  }
  release_channel {
    channel = "REGULAR"
  }
  security_posture_config {
    mode               = "BASIC"
    vulnerability_mode = "VULNERABILITY_DISABLED"
  }

  node_pool_defaults {
    node_config_defaults {
      logging_variant = "DEFAULT"
    }
  }

}

resource "google_container_node_pool" "one" {
  name    = "one"
  cluster = google_container_cluster.primary

  node_config {
    machine_type = "e2-medium"

    image_type = "COS_CONTAINERD"

    disk_type    = "pd-balanced"
    disk_size_gb = 50
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.

    preemptible = false

    service_account = var.gke-sa.email

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }

  network_config {

  }

}
