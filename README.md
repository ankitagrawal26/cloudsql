# GCP Cloud SQL Terraform Module

A Terraform module for provisioning and managing Google Cloud SQL instances with support for MySQL, PostgreSQL, and SQL Server.

## Features

- ✅ Multi-Database Support (MySQL, PostgreSQL, SQL Server)
- ✅ High Availability (ZONAL/REGIONAL)
- ✅ Automated Backups with Point-in-Time Recovery
- ✅ Private IP & Network Security
- ✅ Query Insights & Monitoring
- ✅ Database & User Management

## Quick Start

### Basic Example

```hcl
module "cloud_sql" {
  source = "path/to/module"

  name       = "my-cloud-sql-instance"
  project_id = data.google_client_config.current.project
  region     = "us-central1"

  database_version = "MYSQL_8_0"
  tier             = "db-f1-micro"
  disk_size        = 10
}

data "google_client_config" "current" {}
```

### Complete Example

```hcl
module "cloud_sql" {
  source = "path/to/module"

  name       = "my-cloud-sql-instance"
  project_id = data.google_client_config.current.project
  region     = "us-central1"

  database_version  = "MYSQL_8_0"
  tier              = "db-g1-small"
  availability_type = "REGIONAL"
  
  backup_configuration = {
    enabled                        = true
    start_time                     = "03:00"
    point_in_time_recovery_enabled = true
    transaction_log_retention_days = 7
    retained_backups               = 7
    retention_unit                 = "COUNT"
    location                       = null
  }

  create_database = true
  database_name   = "mydatabase"
  
  create_user  = true
  user_name     = "dbuser"
  user_password = "secure-password"
}

data "google_client_config" "current" {}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| google | ~> 5.0 |

## Key Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Cloud SQL instance name | `string` | n/a | yes |
| project_id | GCP project ID | `string` | n/a | yes |
| region | GCP region | `string` | n/a | yes |
| database_version | Database version | `string` | `"MYSQL_8_0"` | no |
| tier | Machine type | `string` | `"db-f1-micro"` | no |
| availability_type | ZONAL or REGIONAL | `string` | `"ZONAL"` | no |
| disk_size | Disk size in GB | `number` | `10` | no |
| create_database | Create database | `bool` | `false` | no |
| create_user | Create user | `bool` | `false` | no |
| deletion_protection | Enable deletion protection | `bool` | `false` | no |

> **Note**: `project_id` can be extracted from Google credentials using `data.google_client_config.current.project` instead of hardcoding.

## Key Outputs

| Name | Description |
|------|-------------|
| instance_name | Cloud SQL instance name |
| connection_name | Connection name for Cloud SQL Proxy |
| ip_address | Public IPv4 address |
| private_ip_address | Private IPv4 address |
| database_name | Created database name (if created) |
| user_name | Created user name (if created) |

## Examples

- **[Basic Example](./tftest/basic/)** - Minimal configuration
- **[Complete Example](./tftest/complete/)** - Full-featured configuration

## Documentation

- **[Architecture & Flow](./docs/architecture.md)** - Module architecture, deployment flow, and diagrams

## Usage

```bash
# Initialize Terraform
terraform init

# Validate configuration
terraform validate

# Plan deployment
terraform plan

# Apply configuration
terraform apply
```

## CI/CD

GitHub Actions workflows include:
- Security scanning (TFSec, Trivy, Checkov)
- Linting (TFLint)
- Terraform validation and planning

## Contributing

See [CONTRIBUTING.md](./CONTRIBUTING.md) for guidelines.

## Changelog

See [CHANGELOG.md](./CHANGELOG.md) for version history.
