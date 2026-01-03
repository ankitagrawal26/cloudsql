# GCP Cloud SQL Instance
resource "google_sql_database_instance" "main" {
  name                = local.instance_name
  database_version    = var.database_version
  region              = var.region
  project             = var.project_id
  deletion_protection = var.deletion_protection

  settings {
    tier                  = var.tier
    availability_type     = var.availability_type
    disk_type             = var.disk_type
    disk_size             = var.disk_size
    disk_autoresize       = var.disk_autoresize
    disk_autoresize_limit = var.disk_autoresize_limit
    user_labels           = local.all_labels

    # IP Configuration
    ip_configuration {
      ipv4_enabled                                  = var.ipv4_enabled
      private_network                               = var.private_network
      enable_private_path_for_google_cloud_services = var.enable_private_path_for_google_cloud_services

      dynamic "authorized_networks" {
        for_each = var.authorized_networks
        content {
          name  = authorized_networks.value.name
          value = authorized_networks.value.value
        }
      }
    }

    # Backup Configuration
    dynamic "backup_configuration" {
      for_each = var.backup_configuration != null ? [var.backup_configuration] : []
      content {
        enabled                        = backup_configuration.value.enabled
        start_time                     = backup_configuration.value.start_time
        point_in_time_recovery_enabled = backup_configuration.value.point_in_time_recovery_enabled
        transaction_log_retention_days = backup_configuration.value.transaction_log_retention_days

        dynamic "backup_retention_settings" {
          for_each = backup_configuration.value.retained_backups != null && backup_configuration.value.retained_backups > 0 ? [1] : []
          content {
            retained_backups = backup_configuration.value.retained_backups
            retention_unit   = backup_configuration.value.retention_unit
          }
        }

        location = backup_configuration.value.location
      }
    }

    # Maintenance Window
    dynamic "maintenance_window" {
      for_each = var.maintenance_window != null ? [var.maintenance_window] : []
      content {
        day          = maintenance_window.value.day
        hour         = maintenance_window.value.hour
        update_track = maintenance_window.value.update_track
      }
    }

    # Insights Configuration
    dynamic "insights_config" {
      for_each = var.insights_config != null ? [var.insights_config] : []
      content {
        query_insights_enabled  = insights_config.value.query_insights_enabled
        query_string_length     = insights_config.value.query_string_length
        record_application_tags = insights_config.value.record_application_tags
        record_client_address   = insights_config.value.record_client_address
      }
    }

    # Database Flags
    dynamic "database_flags" {
      for_each = var.database_flags != null ? var.database_flags : []
      content {
        name  = database_flags.value.name
        value = database_flags.value.value
      }
    }

    # Location Preference (for HA)
    dynamic "location_preference" {
      for_each = var.location_preference != null ? [var.location_preference] : []
      content {
        zone                   = location_preference.value.zone
        secondary_zone         = location_preference.value.secondary_zone
        follow_gae_application = location_preference.value.follow_gae_application
      }
    }
  }

  # Replica Configuration (for read replicas)
  dynamic "replica_configuration" {
    for_each = var.replica_configuration != null ? [var.replica_configuration] : []
    content {
      dump_file_path            = replica_configuration.value.dump_file_path
      username                  = replica_configuration.value.username
      password                  = replica_configuration.value.password
      connect_retry_interval    = replica_configuration.value.connect_retry_interval
      master_heartbeat_period   = replica_configuration.value.master_heartbeat_period
      ssl_cipher                = replica_configuration.value.ssl_cipher
      verify_server_certificate = replica_configuration.value.verify_server_certificate
    }
  }

}

# Cloud SQL Database
resource "google_sql_database" "main" {
  count     = var.create_database ? 1 : 0
  name      = var.database_name
  instance  = google_sql_database_instance.main.name
  project   = var.project_id
  charset   = var.database_charset
  collation = var.database_collation
}

# Cloud SQL User
resource "google_sql_user" "main" {
  count    = var.create_user && var.user_name != null ? 1 : 0
  name     = var.user_name
  instance = google_sql_database_instance.main.name
  project  = var.project_id
  password = var.user_password
  type     = var.user_type
  host     = var.user_host
}
##