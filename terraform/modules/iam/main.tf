resource "google_project_iam_member" "cloud_function_service_account_roles" {
  for_each = toset([
    "roles/cloudfunctions.developer",
    "roles/storage.objectAdmin",
    "roles/pubsub.editor",
    "roles/datastore.user"
  ])

  project = var.project_id
  role    = each.key
  member  = "serviceAccount:${var.service_account_email}"
}