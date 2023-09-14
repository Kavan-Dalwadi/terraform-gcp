resource "google_service_account" "service_account" {
  account_id   = "gke-node-pool"
  display_name = "GKE node-pool"
}