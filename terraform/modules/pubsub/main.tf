resource "google_pubsub_topic" "shift_claimer_start" {
  name    = "shift-claimer-start"
  project = var.project_id
}

resource "google_pubsub_topic" "shift_claimer_cooldown" {
  name    = "shift-claimer-cooldown"
  project = var.project_id
}

resource "google_pubsub_subscription" "shift_claimer_start_sub" {
  name    = "shift-claimer-start-sub"
  project = var.project_id
  topic   = google_pubsub_topic.shift_claimer_start.name
}

resource "google_pubsub_subscription" "shift_claimer_cooldown_sub" {
  name    = "shift-claimer-cooldown-sub"
  project = var.project_id
  topic   = google_pubsub_topic.shift_claimer_cooldown.name
}