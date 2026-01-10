# Context Infrastructure

Cloud infrastructure for context. Built with Terraform on AWS, localized to London (eu-west-2).

## Architecture Overview

| Component | Description |
|-----------|-------------|
| **Networking** | Custom VPC with 1 Public Subnet (Bastion) and 2 Private Subnets (RDS) |
| **Database** | PostgreSQL 15 (RDS) inside a private subnet. Vector support enabled via pgvector |
| **Storage** | S3 Bucket (`context-dev-data-uk`) with lifecycle rules (90 days to Glacier) and versioning |
| **Access** | Secure SSH Tunneling via a Bastion Host (t3.micro) |

## Quick Start

### 1. Connect to the Database

The RDS instance is private. You must open an SSH tunnel to connect from your local machine:

```bash
# Start the tunnel (keep this terminal open)
ssh -i ~/.ssh/id_rsa -L 5432:<RDS_ENDPOINT>:5432 ec2-user@<BASTION_IP>

# Get the actual values from Terraform outputs:
cd environments/dev
terraform output bastion_rds_tunnel_command
```

### 2. Local Connection Params (via Tunnel)

| Parameter | Value |
|-----------|-------|
| Host | `localhost` |
| Port | `5432` |
| User | `postgres` |
| DB Name | `contextdb` |
| Password | Stored in `terraform.tfvars` (do not commit!) |

### 3. Infrastructure Management

```bash
cd environments/dev
terraform plan        # Preview changes
terraform apply       # Deploy changes
terraform outoutputs  # View useful info (endpoints, commands)
terraform destroy     # Tear down all resources
```

## Maintenance Notes

### My IP Changed

The Bastion host only accepts SSH traffic from your specific home IP. If you can't connect:

1. Check your current IP (Google "What is my IP")
2. Update `my_ip_cidr` in `environments/dev/terraform.tfvars`
3. Run `terraform apply`

### Costs

| Resource | Cost |
|----------|------|
| RDS & EC2 | Free Tier eligible (`db.t3.micro` & `t3.micro`) |
| S3 | Billed by usage (minimal) |

**To Stop Costs:** Run `terraform destroy` (Warning: This deletes the database data!)

## Directory Structure

```
context-infra/
├── modules/
│   ├── networking/     # VPC, Subnets, Security Groups
│   ├── rds/            # PostgreSQL database
│   ├── s3/             # Data storage bucket
│   └── bastion/        # Jump box for secure access
├── environments/
│   └── dev/            # Development environment config
└── rds/
    └── migrations/     # SQL schema migrations
```

| Path | Purpose |
|------|---------|
| `modules/` | Reusable Terraform blueprints |
| `environments/dev/` | Environment-specific settings and state |
| `.gitignore` | Ignores `.tfstate` and `terraform.tfvars` to protect secrets |

## Requirements

- Terraform >= 1.0
- AWS CLI configured with credentials
- SSH key pair (`~/.ssh/id_rsa`)
- PostgreSQL client (for migrations)
