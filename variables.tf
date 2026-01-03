variable "name" {
  description = "Name of the Cloud SQL instance (will be prefixed with project/environment)"
  type        = string

  validation {
    condition     = length(var.name) > 0 && length(var.name) <= 64
    error_message = "Name must be between 1 and 64 characters."
  }
}

variable "project_id" {
  description = "The GCP project ID where resources will be created"
  type        = string

  validation {
    condition     = length(var.project_id) > 0
    error_message = "Project ID cannot be empty."
  }
}

variable "region" {
  description = "GCP region where the Cloud SQL instance will be created"
  type        = string

  validation {
    condition     = length(var.region) > 0
    error_message = "Region cannot be empty."
  }
}

variable "database_version" {
  description = "The database version to use (e.g., MYSQL_8_0, POSTGRES_15, SQLSERVER_2019_STANDARD)"
  type        = string
  default     = "MYSQL_8_0"

  validation {
    condition     = can(regex("^(MYSQL|POSTGRES|SQLSERVER)", var.database_version))
    error_message = "Database version must be a valid MySQL, PostgreSQL, or SQL Server version."
  }
}

variable "tier" {
  description = "The machine type (tier) to use for the instance"
  type        = string
  default     = "db-f1-micro"
}

variable "availability_type" {
  description = "The availability type of the Cloud SQL instance (REGIONAL for HA, ZONAL for single zone)"
  type        = string
  default     = "ZONAL"

  validation {
    condition     = contains(["ZONAL", "REGIONAL"], var.availability_type)
    error_message = "Availability type must be either ZONAL or REGIONAL."
  }
}

variable "disk_type" {
  description = "The type of disk (PD_SSD or PD_HDD)"
  type        = string
  default     = "PD_SSD"

  validation {
    condition     = contains(["PD_SSD", "PD_HDD"], var.disk_type)
    error_message = "Disk type must be either PD_SSD or PD_HDD."
  }
}

variable "disk_size" {
  description = "The size of data disk, in GB"
  type        = number
  default     = 10

  validation {
    condition     = var.disk_size >= 10 && var.disk_size <= 65536
    error_message = "Disk size must be between 10 and 65536 GB."
  }
}

variable "disk_autoresize" {
  description = "Whether to enable automatic disk resize"
  type        = bool
  default     = true
}

variable "disk_autoresize_limit" {
  description = "The maximum size to which storage can be automatically increased"
  type        = number
  default     = 0
}

variable "deletion_protection" {
  description = "Whether to enable deletion protection"
  type        = bool
  default     = false
}

variable "ipv4_enabled" {
  description = "Whether to enable IPv4 connectivity"
  type        = bool
  default     = true
}

variable "private_network" {
  description = "The VPC network from which the Cloud SQL instance is accessible for private IP"
  type        = string
  default     = null
}

# Note: require_ssl is deprecated in favor of SSL mode settings
# SSL enforcement is now handled via database flags or connection settings

variable "enable_private_path_for_google_cloud_services" {
  description = "Whether to enable private path for Google Cloud services"
  type        = bool
  default     = false
}

variable "authorized_networks" {
  description = "List of authorized networks to allow access to the instance"
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

variable "backup_configuration" {
  description = "Backup configuration for the instance"
  type = object({
    enabled                        = bool
    start_time                     = string
    point_in_time_recovery_enabled = bool
    transaction_log_retention_days = number
    retained_backups               = number
    retention_unit                 = string
    location                       = string
  })
  default = null
}

variable "maintenance_window" {
  description = "Maintenance window configuration"
  type = object({
    day          = number
    hour         = number
    update_track = string
  })
  default = null
}

variable "insights_config" {
  description = "Query insights configuration"
  type = object({
    query_insights_enabled  = bool
    query_string_length     = number
    record_application_tags = bool
    record_client_address   = bool
  })
  default = null
}

variable "database_flags" {
  description = "List of database flags to set"
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

variable "location_preference" {
  description = "Location preference for the instance"
  type = object({
    zone                   = string
    secondary_zone         = string
    follow_gae_application = bool
  })
  default = null
}

variable "replica_configuration" {
  description = "Replica configuration (for read replicas)"
  type = object({
    dump_file_path            = string
    username                  = string
    password                  = string
    connect_retry_interval    = number
    master_heartbeat_period   = number
    ssl_cipher                = string
    verify_server_certificate = bool
  })
  default   = null
  sensitive = true
}

variable "create_database" {
  description = "Whether to create a database"
  type        = bool
  default     = false
}

variable "database_name" {
  description = "Name of the database to create"
  type        = string
  default     = null
}

variable "database_charset" {
  description = "The charset for the database"
  type        = string
  default     = null
}

variable "database_collation" {
  description = "The collation for the database"
  type        = string
  default     = null
}

variable "create_user" {
  description = "Whether to create a database user"
  type        = bool
  default     = false
}

variable "user_name" {
  description = "Name of the database user"
  type        = string
  default     = null
}

variable "user_password" {
  description = "Password for the database user"
  type        = string
  default     = null
  sensitive   = true
}

variable "user_type" {
  description = "Type of the database user (BUILT_IN or CLOUD_IAM)"
  type        = string
  default     = "BUILT_IN"

  validation {
    condition     = contains(["BUILT_IN", "CLOUD_IAM"], var.user_type)
    error_message = "User type must be either BUILT_IN or CLOUD_IAM."
  }
}

variable "user_host" {
  description = "Host for the database user"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags/labels to apply to all resources"
  type        = map(string)
  default     = {}
}

variable "environment" {
  description = "Environment name (e.g., dev, qa, prod)"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "qa", "uat", "prod"], var.environment)
    error_message = "Environment must be one of: dev, qa, uat, prod."
  }
}

