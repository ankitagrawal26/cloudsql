output "instance_name" {
  description = "The name of the Cloud SQL instance"
  value       = module.cloud_sql.instance_name
}

output "connection_name" {
  description = "The connection name of the Cloud SQL instance"
  value       = module.cloud_sql.connection_name
}

output "ip_address" {
  description = "The IPv4 address assigned to the Cloud SQL instance"
  value       = module.cloud_sql.ip_address
}

output "self_link" {
  description = "The URI of the Cloud SQL instance"
  value       = module.cloud_sql.self_link
}
