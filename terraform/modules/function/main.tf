data "archive_file" "function_archive" {
  type        = "zip"
  source_dir  = var.function_source_dir
  output_path = "${var.function_name}.zip"
}

resource "google_storage_bucket_object" "function_archive" {
  name   = "${var.function_name}.zip"
  bucket = var.functions_bucket_name
  source = "${var.function_name}.zip"
  depends_on = [ data.archive_file.function_archive ]
}

resource "google_cloudfunctions2_function" "function" {
  name        = var.function_name
  location    = var.region
  description = "Cloud Function."

  build_config {
    runtime     = var.function_runtime
    entry_point = var.function_entry_point
    source {
      storage_source {
        bucket = var.functions_bucket_name
        object = google_storage_bucket_object.function_archive.name
      }
    }
  }

  service_config {
    max_instance_count    = 1
    available_memory      = "256M"
    timeout_seconds       = 60
    service_account_email = var.service_account_email
  }

  dynamic "event_trigger" {
    for_each = var.trigger_type == "pubsub" ? [1] : []
    content {
      trigger_region = var.region
      event_type     = "google.cloud.pubsub.topic.v1.messagePublished"
      pubsub_topic   = var.pubsub_topic
      retry_policy   = "RETRY_POLICY_RETRY"
    }
  }
  depends_on = [ data.archive_file.function_archive, google_storage_bucket_object.function_archive ]
}
