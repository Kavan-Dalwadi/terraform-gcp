# Provider Configuration
provider "google" {
  credentials = file("./key.json")
  project     = "playground-s-11-6c48b791"
  region      = "us-central1"
}

# Define the Virtual Machine Instances
resource "google_compute_instance" "vm_instance" {
  name         = "vm-instance-${count.index}"
  machine_type = "e2-medium"
  zone         = "us-central1-a"
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }
  network_interface {
    network = "default"
    # network = "existing-vpc-network"
    # subnetwork = "existing-vpc-subnet"
    access_config {
      // Ephemeral IP will be automatically assigned
    }
  }
#   tags = ["allow-http"  ]
  metadata_startup_script = "sudo apt-get update && sudo apt-get install nginx -y"
  count = 2
}

# Define the HTTP Health Check
resource "google_compute_http_health_check" "health_check" {
  name               = "http-health-check"
  check_interval_sec = 5
  timeout_sec        = 5
  unhealthy_threshold = 2
  healthy_threshold   = 2
  request_path       = "/"
  port               = 80
}


# Define the Target Pool
resource "google_compute_target_pool" "load_balancer_pool" {
  name             = "load-balancer-pool"
  region           = "us-central1"
  health_checks    = [google_compute_http_health_check.health_check.self_link]
  instances        = google_compute_instance.vm_instance.*.self_link
  session_affinity = "NONE"
}



# Define the Forwarding Rule
resource "google_compute_forwarding_rule" "load_balancer" {
  name                  = "load-balancer"
  region                = "us-central1"
  target                = google_compute_target_pool.load_balancer_pool.self_link
  load_balancing_scheme = "EXTERNAL"
  port_range            = "80"
}

resource "google_compute_firewall" "allow_http" {
  name    = "allow-http"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  source_ranges = ["10.128.0.0/20"]  # Replace with your VPC CIDR range
}


###########################################################################################################


provider "google" {
  credentials = file("path/to/service/account/key.json")
  project     = "your-project-id"
  region      = "us-central1"
}

resource "google_compute_instance" "vm_instance" {
  count        = 2
  name         = "my-vm-instance-${count.index}"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
    }
  }
  network_interface {
    network = "existing-vpc-network"
    subnetwork = "existing-vpc-subnet"
    access_config {
      // No external IP address
    }
  }
}

resource "google_compute_backend_service" "backend_service" {
  name             = "my-backend-service"
  port             = 80
  protocol         = "HTTP"
  backend {
    group = google_compute_instance.vm_instance.self_link
  }
}


resource "google_compute_url_map" "url_map" {
  name            = "my-url-map"
  default_service = google_compute_backend_service.backend_service.self_link
}

resource "google_compute_ssl_certificate" "ssl_certificate" {
  name        = "my-ssl-certificate"
  certificate = file("path/to/ssl/certificate.pem")
  private_key = file("path/to/private/key.pem")
}

resource "google_compute_target_https_proxy" "target_https_proxy" {
  name              = "my-target-https-proxy"
  ssl_certificates = [google_compute_ssl_certificate.ssl_certificate.self_link]
}

resource "google_compute_global_forwarding_rule" "forwarding_rule" {
  name                  = "my-forwarding-rule"
  target                = google_compute_target_https_proxy.target_https_proxy.self_link
  port_range            = "443"
  load_balancing_scheme = "EXTERNAL"
  ip_address            = "your-static-ip-address"
}

