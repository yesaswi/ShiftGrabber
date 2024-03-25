resource "google_storage_bucket" "functions_bucket" {
  name          = var.functions_bucket_name
  location      = var.region
  force_destroy = true
}
