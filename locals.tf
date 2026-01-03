locals {
  # Standard labels applied to all resources
  standard_labels = {
    ManagedBy   = "Terraform"
    Module      = "gcp-cloud-sql"
    Environment = var.environment
  }

  # Merge standard labels with user-provided tags
  all_labels = merge(local.standard_labels, var.tags)

  # Generate instance name with prefix
  instance_name = format("%s-%s", var.name, var.environment)

  # Generate connection name
  connection_name = format("%s:%s:%s", var.project_id, var.region, local.instance_name)
}
