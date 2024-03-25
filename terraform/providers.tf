provider "google" {
  project     = var.project_id
  region      = var.region
  credentials = file("autoclaimer-42-credentials.json")
}
