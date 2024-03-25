resource "google_firestore_database" "auto_claimer_db" {
    project = var.project_id
    name = var.firestore_db_name
    location_id = var.region
    type = "FIRESTORE_NATIVE"
}
