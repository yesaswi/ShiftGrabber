terraform {
  backend "gcs" {
    bucket = "autoclaimer-42-tfstate"
    prefix = "terraform/state"
  }
}
