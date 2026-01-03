resource "random_id" "suffix" {
  byte_length = 4
}

# Complete Cloud SQL instance example with all features
module "cloud_sql" {
  source = "../.."

  # Required variables
  name       = "complete-cloud-sql-${random_id.suffix.hex}"
  project_id = data.google_client_config.current.project
  region     = var.region

  # Database configuration
  database_version  = var.database_version
  tier              = var.tier
  availability_type = var.availability_type

  # Disk configuration
  disk_type             = var.disk_type
  disk_size             = var.disk_size
  disk_autoresize       = var.disk_autoresize
  disk_autoresize_limit = var.disk_autoresize_limit

  # Network configuration
  ipv4_enabled                                  = var.ipv4_enabled
  private_network                               = var.private_network
  enable_private_path_for_google_cloud_services = var.enable_private_path_for_google_cloud_services
  authorized_networks                           = var.authorized_networks

  # Backup configuration
  backup_configuration = var.backup_configuration

  # Maintenance window
  maintenance_window = var.maintenance_window

  # Insights configuration
  insights_config = var.insights_config

  # Database flags
  database_flags = var.database_flags

  # Location preference
  location_preference = var.location_preference

  # Database creation
  create_database    = var.create_database
  database_name      = var.database_name
  database_charset   = var.database_charset
  database_collation = var.database_collation

  # User creation
  create_user   = var.create_user
  user_name     = var.user_name
  user_password = var.user_password
  user_type     = var.user_type
  user_host     = var.user_host

  # Protection
  deletion_protection = var.deletion_protection

  # Labels
  tags = var.tags
}
