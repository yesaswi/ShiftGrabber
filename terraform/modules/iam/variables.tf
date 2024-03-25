variable "functions" {
  description = "Map of function configurations."
  type = map(object({
    name = string
  }))
}

variable "region" {
  description = "The region where the functions are deployed."
  type        = string
}

variable "project_id" {
  description = "The ID of the GCP project."
  type        = string
}

variable "service_account_email" {
  description = "The email of the cloud function service account."
  type        = string
}
