# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform
resource "google_container_cluster" "console-cluster" {
  allow_net_admin             = null
  cluster_ipv4_cidr           = "10.4.0.0/14"
  datapath_provider           = "LEGACY_DATAPATH"
  default_max_pods_per_node   = 110
  description                 = null
  enable_autopilot            = false
  enable_intranode_visibility = false
  enable_kubernetes_alpha     = false
  enable_l4_ilb_subsetting    = false
  enable_legacy_abac          = false
  enable_shielded_nodes       = true
  enable_tpu                  = false
  initial_node_count          = 0
  location                    = "us-central1"
  logging_service             = "logging.googleapis.com/kubernetes"
  min_master_version          = null
  monitoring_service          = "monitoring.googleapis.com/kubernetes"
  name                        = "console-release-channel"
  network                     = "projects/playground-s-11-f1e6f897/global/networks/custom-vpc"
  networking_mode             = "VPC_NATIVE"
  node_locations              = ["us-central1-a", "us-central1-c", "us-central1-f"]
  node_version                = "1.27.3-gke.100"
  private_ipv6_google_access  = null
  project                     = "playground-s-11-f1e6f897"
  remove_default_node_pool    = null
  resource_labels             = {}
  subnetwork                  = "projects/playground-s-11-f1e6f897/regions/us-central1/subnetworks/us-central1-subnet"
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
  authenticator_groups_config {
    security_group = ""
  }
  binary_authorization {
    evaluation_mode = "DISABLED"
  }
  cluster_autoscaling {
    enabled = false
  }
  database_encryption {
    key_name = null
    state    = "DECRYPTED"
  }
  default_snat_status {
    disabled = false
  }
  ip_allocation_policy {
    cluster_ipv4_cidr_block       = "10.4.0.0/14"
    cluster_secondary_range_name  = "gke-console-release-channel-pods-22b6a282"
    services_ipv4_cidr_block      = "10.8.0.0/20"
    services_secondary_range_name = "gke-console-release-channel-services-22b6a282"
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
  node_config {
    boot_disk_kms_key = null
    disk_size_gb      = 100
    disk_type         = "pd-balanced"
    guest_accelerator = []
    image_type        = "COS_CONTAINERD"
    labels            = {}
    local_ssd_count   = 0
    logging_variant   = "DEFAULT"
    machine_type      = "e2-medium"
    metadata = {
      disable-legacy-endpoints = "true"
    }
    min_cpu_platform = null
    node_group       = null
    oauth_scopes     = ["https://www.googleapis.com/auth/devstorage.read_only", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring", "https://www.googleapis.com/auth/service.management.readonly", "https://www.googleapis.com/auth/servicecontrol", "https://www.googleapis.com/auth/trace.append"]
    preemptible      = false
    resource_labels  = {}
    service_account  = "default"
    spot             = false
    tags             = []
    taint            = []
    shielded_instance_config {
      enable_integrity_monitoring = true
      enable_secure_boot          = false
    }
  }
  
  node_pool_defaults {
    node_config_defaults {
      logging_variant = "DEFAULT"
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
  service_external_ips_config {
    enabled = false
  }
}