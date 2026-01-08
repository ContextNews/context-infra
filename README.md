# Context Infrastructure

Terraform and database configurations for the Context news aggregation system.

## Structure

```
context-infra/
├── rds/
│   ├── terraform/      # RDS Postgres provisioning
│   └── migrations/     # SQL schema migrations
```

## Components

### RDS (`rds/`)
PostgreSQL database for storing articles, stories, and their relationships. See [rds/README.md](rds/README.md) for schema details.

**Provision:**
```bash
cd rds/terraform
cp terraform.tfvars.example terraform.tfvars  # Edit with your values
terraform init
terraform apply
```

**Run migrations:**
```bash
psql -h <endpoint> -U <user> -d context -f rds/migrations/001_init.sql
psql -h <endpoint> -U <user> -d context -f rds/migrations/002_indexes.sql
psql -h <endpoint> -U <user> -d context -f rds/migrations/003_constraints.sql
```

## Requirements

- Terraform >= 1.0
- AWS CLI configured with appropriate credentials
- PostgreSQL client (for migrations)
