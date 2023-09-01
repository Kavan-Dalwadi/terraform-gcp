resource "google_compute_network" "vpc_network" {
  project                 = var.project_id
  name                    = var.vpc_name
  auto_create_subnetworks = false
  mtu                     = var.mtu
}

resource "google_compute_subnetwork" "subnetwork-internal-ipv6" {
  name          = "${var.subnet_name_list[count.index]}-subnet"

  count = length(var.subnet_name_list)

  ip_cidr_range = var.subnet_cidr_list[count.index]
  region        = var.subnet_name_list[count.index]

  stack_type       = "IPV4_ONLY"

  network       = google_compute_network.vpc_network.id
}