variable "region" {
  description = "The GCP region"
  type        = string
  default     = "us-central1"
}

variable "database_version" {
  description = "The database version to use"
  type        = string
  default     = "MYSQL_8_0"
}

variable "tier" {
  description = "The machine type (tier) to use for the instance"
  type        = string
  default     = "db-g1-small"
}

variable "availability_type" {
  description = "The availability type of the Cloud SQL instance"
  type        = string
  default     = "REGIONAL"
}

variable "disk_type" {
  description = "The type of disk"
  type        = string
  default     = "PD_SSD"
}

variable "disk_size" {
  description = "The size of data disk, in GB"
  type        = number
  default     = 20
}

variable "disk_autoresize" {
  description = "Whether to enable automatic disk resize"
  type        = bool
  default     = true
}

variable "disk_autoresize_limit" {
  description = "The maximum size to which storage can be automatically increased"
  type        = number
  default     = 100
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
  default     = true
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
  default = {
    enabled                        = true
    start_time                     = "03:00"
    point_in_time_recovery_enabled = true
    transaction_log_retention_days = 7
    retained_backups               = 7
    retention_unit                 = "COUNT"
    location                       = null
  }
}

variable "maintenance_window" {
  description = "Maintenance window configuration"
  type = object({
    day          = number
    hour         = number
    update_track = string
  })
  default = {
    day          = 7
    hour         = 3
    update_track = "stable"
  }
}

variable "insights_config" {
  description = "Query insights configuration"
  type = object({
    query_insights_enabled  = bool
    query_string_length     = number
    record_application_tags = bool
    record_client_address   = bool
  })
  default = {
    query_insights_enabled  = true
    query_string_length     = 1024
    record_application_tags = true
    record_client_address   = true
  }
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

variable "create_database" {
  description = "Whether to create a database"
  type        = bool
  default     = true
}

variable "database_name" {
  description = "Name of the database to create"
  type        = string
  default     = "mydatabase"
}

variable "database_charset" {
  description = "The charset for the database"
  type        = string
  default     = "utf8mb4"
}

variable "database_collation" {
  description = "The collation for the database"
  type        = string
  default     = "utf8mb4_general_ci"
}

variable "create_user" {
  description = "Whether to create a database user"
  type        = bool
  default     = true
}

variable "user_name" {
  description = "Name of the database user"
  type        = string
  default     = "dbuser"
}

variable "user_password" {
  description = "Password for the database user"
  type        = string
  default     = null
  sensitive   = true
}

variable "user_type" {
  description = "Type of the database user"
  type        = string
  default     = "BUILT_IN"
}

variable "user_host" {
  description = "Host for the database user"
  type        = string
  default     = null
}

variable "deletion_protection" {
  description = "Whether to enable deletion protection"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags/labels to apply to all resources"
  type        = map(string)
  default = {
    Environment = "production"
    Example     = "complete"
    ManagedBy   = "terraform"
    Owner       = "platform-team"
    CostCenter  = "infrastructure"
  }
}

