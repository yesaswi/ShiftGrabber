resource "google_service_account" "cloud_function_service_account" {
  account_id   = "cloud-function-service-account"
  display_name = "Cloud Function Service Account"
}

module "storage" {
  source               = "./modules/storage"
  functions_bucket_name = "autoclaimer-42-functions-bucket"
  region               = var.region
  project_id           = var.project_id
}

module "pubsub" {
  source     = "./modules/pubsub"
  project_id = var.project_id
}

module "function" {
  source                = "./modules/function"
  for_each              = var.functions
  function_name         = each.value.name
  function_entry_point  = each.value.entry_point
  function_source_dir   = each.value.source_dir
  function_runtime      = "python312"
  functions_bucket_name = module.storage.functions_bucket_name
  service_account_email = google_service_account.cloud_function_service_account.email
  region                = var.region
  project_id            = var.project_id
  depends_on            = [module.storage, module.pubsub]
  trigger_type          = each.value.trigger_type
  pubsub_topic          = each.value.pubsub_topic
}

module "cloud_function_iam" {
  source                = "./modules/iam"
  functions             = var.functions
  region                = var.region
  project_id            = var.project_id
  depends_on            = [module.function]
  service_account_email = google_service_account.cloud_function_service_account.email
}

module "firestore" {
  source = "./modules/firestore"
  project_id = var.project_id
  region = var.region
  firestore_db_name = "autoclaimer-42-db"
  depends_on = [ module.function ]
}