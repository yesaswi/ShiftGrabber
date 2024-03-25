variable "firestore_db_name" {
  description = "The name of the Firestore database."
  type        = string
}

variable "region" {
  description = "The region where the bucket will be created."
  type        = string
}

variable "project_id" {
  description = "The ID of the GCP project."
  type        = string
}
