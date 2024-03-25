variable "function_name" {
  description = "The name of the Cloud Function."
  type        = string
}

variable "function_entry_point" {
  description = "The entry point of the Cloud Function."
  type        = string
}

variable "function_source_dir" {
  description = "The directory containing the source code for the Cloud Function."
  type        = string
}

variable "function_runtime" {
  description = "The runtime environment for the Cloud Functions."
  type        = string
}

variable "functions_bucket_name" {
  description = "The name of the bucket to store the functions code."
  type        = string
}

variable "trigger_type" {
  type        = string
  description = "The trigger type for the function (http or pubsub)"
}

variable "pubsub_topic" {
  type        = string
  description = "The Pub/Sub topic that triggers the function (required for pubsub trigger)"
  default     = null
}

variable "service_account_email" {
  description = "The email address of the service account for the functions."
  type        = string
}

variable "region" {
  description = "The region where the functions will be deployed."
  type        = string
}

variable "project_id" {
  description = "The ID of the GCP project."
  type        = string
}
