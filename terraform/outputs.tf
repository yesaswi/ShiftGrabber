output "function_urls" {
  value = { for k, v in module.function : k => v.function_url }
}

output "function_names" {
  value = { for k, v in module.function : k => v.function_name }
}

output "functions_bucket_name" {
  value = module.storage.functions_bucket_name
}
