output "instance_name" {
  description = "The name of the Cloud SQL instance"
  value       = module.cloud_sql.instance_name
}

output "instance_id" {
  description = "The ID of the Cloud SQL instance"
  value       = module.cloud_sql.instance_id
}

output "connection_name" {
  description = "The connection name of the Cloud SQL instance"
  value       = module.cloud_sql.connection_name
}

output "ip_address" {
  description = "The IPv4 address assigned to the Cloud SQL instance"
  value       = module.cloud_sql.ip_address
}

output "private_ip_address" {
  description = "The private IPv4 address assigned to the Cloud SQL instance"
  value       = module.cloud_sql.private_ip_address
}

output "public_ip_address" {
  description = "The public IPv4 address assigned to the Cloud SQL instance"
  value       = module.cloud_sql.public_ip_address
}

output "self_link" {
  description = "The URI of the Cloud SQL instance"
  value       = module.cloud_sql.self_link
}

output "service_account_email_address" {
  description = "The service account email address assigned to the Cloud SQL instance"
  value       = module.cloud_sql.service_account_email_address
}

output "database_name" {
  description = "The name of the created database"
  value       = module.cloud_sql.database_name
}

output "database_id" {
  description = "The ID of the created database"
  value       = module.cloud_sql.database_id
}

output "user_name" {
  description = "The name of the created database user"
  value       = module.cloud_sql.user_name
}

output "user_id" {
  description = "The ID of the created database user"
  value       = module.cloud_sql.user_id
}
