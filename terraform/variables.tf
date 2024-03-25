variable "project_id" {
  description = "The ID of the GCP project."
  type        = string
}

variable "region" {
  description = "The region where resources will be created."
  type        = string
}

variable "functions" {
  type = map(object({
    name         = string
    entry_point  = string
    source_dir   = string
    trigger_type = string
    pubsub_topic = string
  }))
}
