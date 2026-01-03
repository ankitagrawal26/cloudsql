# GCP Cloud SQL Module Architecture

## Overview

Architecture, components, and deployment flow of the GCP Cloud SQL Terraform module.

## Module Structure

```
tf-gcp-cloud-sql/
├── main.tf              # Cloud SQL instance resource
├── variables.tf         # Input variables
├── outputs.tf           # Output values
├── locals.tf            # Computed values
├── versions.tf          # Provider constraints
└── tftest/              # Examples
    ├── basic/           # Basic example
    └── complete/        # Complete example
```

## Component Architecture

```mermaid
graph TB
    A[Module Input] --> B[Cloud SQL Instance]
    B --> C[Database Resource]
    B --> D[User Resource]
    B --> E[IP Configuration]
    B --> F[Backup Configuration]
    B --> G[Maintenance Window]
    B --> H[Query Insights]
    B --> I[Module Outputs]
    
    style A fill:#e1f5ff
    style B fill:#4caf50
    style I fill:#ff9800
```

## Resource Flow

```mermaid
sequenceDiagram
    participant User
    participant Module
    participant GCP as GCP Cloud SQL API
    participant DB as Database Resource
    participant UserRes as User Resource

    User->>Module: Provide Input Variables
    Module->>GCP: Create Cloud SQL Instance
    GCP-->>Module: Instance Created
    
    alt Create Database
        Module->>DB: Create Database
        DB-->>Module: Database Created
    end
    
    alt Create User
        Module->>UserRes: Create User
        UserRes-->>Module: User Created
    end
    
    Module->>User: Return Outputs
```

## Deployment Flow

```mermaid
flowchart TD
    Start([Start]) --> Init[Terraform Init]
    Init --> Validate[Validate Configuration]
    Validate --> Plan[Terraform Plan]
    Plan --> Review{Review Plan}
    Review -->|Approve| Apply[Terraform Apply]
    Review -->|Reject| Modify[Modify Configuration]
    Modify --> Validate
    Apply --> CreateInstance[Create Cloud SQL Instance]
    CreateInstance --> ConfigureSettings[Configure Settings]
    ConfigureSettings --> CreateDB{Create Database?}
    CreateDB -->|Yes| CreateDatabase[Create Database]
    CreateDB -->|No| CreateUser{Create User?}
    CreateDatabase --> CreateUser
    CreateUser -->|Yes| CreateUserRes[Create User]
    CreateUser -->|No| Complete([Complete])
    CreateUserRes --> Complete
    
    style Start fill:#4caf50
    style Complete fill:#4caf50
    style Review fill:#ff9800
```

## Network Architecture

```mermaid
graph LR
    A[Application] -->|Public IP| B[Cloud SQL Instance]
    A -->|Private IP| C[VPC Network]
    C -->|Private Connection| B
    D[Authorized Networks] -->|Allowed IPs| B
    E[Google Services] -->|Private Path| B
    
    style B fill:#4caf50
    style C fill:#2196f3
```

## High Availability Architecture

```mermaid
graph TB
    subgraph "REGIONAL Availability"
        A[Primary Zone] --> B[Cloud SQL Instance]
        C[Secondary Zone] --> B
        B --> D[Synchronous Replication]
    end
    
    subgraph "ZONAL Availability"
        E[Single Zone] --> F[Cloud SQL Instance]
    end
    
    style B fill:#4caf50
    style F fill:#ff9800
```

## Backup & Recovery Flow

```mermaid
flowchart LR
    A[Cloud SQL Instance] -->|Continuous| B[Transaction Logs]
    A -->|Scheduled| C[Backup Storage]
    B --> D[Point-in-Time Recovery]
    C --> E[Backup Retention]
    D --> F[Restore Instance]
    E --> F
    
    style A fill:#4caf50
    style F fill:#2196f3
```

## Security Architecture

```mermaid
graph TB
    A[Cloud SQL Instance] --> B[Network Security]
    A --> C[Access Control]
    A --> D[Encryption]
    
    B --> E[Private IP]
    B --> F[Authorized Networks]
    B --> G[VPC Firewall Rules]
    
    C --> H[IAM Roles]
    C --> I[Database Users]
    
    D --> J[Encryption at Rest]
    D --> K[Encryption in Transit]
    
    style A fill:#4caf50
    style B fill:#f44336
    style C fill:#f44336
    style D fill:#f44336
```

## Module Components

### Cloud SQL Instance
- Database version selection
- Machine tier configuration
- Disk and network settings
- Backup and maintenance windows
- Query insights

### Database Resource (Optional)
- Database name, charset, collation

### User Resource (Optional)
- User name, password, type (BUILT_IN/CLOUD_IAM)

## Best Practices

1. Use **Private IP** for production
2. Enable **Backups** with point-in-time recovery
3. Use **REGIONAL** availability for production
4. Enable **Query Insights** for monitoring
5. Use **Secret Manager** for passwords
6. Enable **Deletion Protection** for production

## Integration Points

- VPC Networks (Private IP)
- IAM (Access control)
- Cloud Monitoring (Metrics)
- Cloud Logging (Audit logs)
- Secret Manager (Passwords)
- Cloud KMS (Encryption keys)
