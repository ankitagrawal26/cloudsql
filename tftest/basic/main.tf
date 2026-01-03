resource "random_id" "suffix" {
  byte_length = 4
}

# Basic Cloud SQL instance example
module "cloud_sql" {
  source = "../.."

  # Required variables
  name       = "basic-cloud-sql-${random_id.suffix.hex}"
  project_id = data.google_client_config.current.project
  region     = var.region

  # Basic configuration
  database_version = "MYSQL_8_0"
  tier             = "db-f1-micro"
  disk_size        = 10
  disk_type        = "PD_SSD"

  # Basic settings
  ipv4_enabled = true

  # Labels
  tags = {
    Environment = "dev"
    Example     = "basic"
    ManagedBy   = "terraform"
  }
}
