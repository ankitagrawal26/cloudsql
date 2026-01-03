output "instance_name" {
  description = "The name of the Cloud SQL instance"
  value       = google_sql_database_instance.main.name
}

output "instance_id" {
  description = "The ID of the Cloud SQL instance"
  value       = google_sql_database_instance.main.id
}

output "connection_name" {
  description = "The connection name of the Cloud SQL instance"
  value       = google_sql_database_instance.main.connection_name
}

output "ip_address" {
  description = "The IPv4 address assigned to the Cloud SQL instance"
  value       = google_sql_database_instance.main.ip_address
}

output "private_ip_address" {
  description = "The private IPv4 address assigned to the Cloud SQL instance"
  value       = google_sql_database_instance.main.private_ip_address
}

output "public_ip_address" {
  description = "The public IPv4 address assigned to the Cloud SQL instance"
  value       = google_sql_database_instance.main.public_ip_address
}

output "self_link" {
  description = "The URI of the Cloud SQL instance"
  value       = google_sql_database_instance.main.self_link
}

output "service_account_email_address" {
  description = "The service account email address assigned to the Cloud SQL instance"
  value       = google_sql_database_instance.main.service_account_email_address
}

output "database_name" {
  description = "The name of the created database"
  value       = var.create_database && var.database_name != null ? google_sql_database.main[0].name : null
}

output "database_id" {
  description = "The ID of the created database"
  value       = var.create_database && var.database_name != null ? google_sql_database.main[0].id : null
}

output "user_name" {
  description = "The name of the created database user"
  value       = var.create_user && var.user_name != null ? google_sql_user.main[0].name : null
}

output "user_id" {
  description = "The ID of the created database user"
  value       = var.create_user && var.user_name != null ? google_sql_user.main[0].id : null
}

output "instance" {
  description = "The Cloud SQL instance resource"
  value       = google_sql_database_instance.main
  sensitive   = false
}
