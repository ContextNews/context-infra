terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

resource "aws_db_subnet_group" "context" {
  name       = "context-db-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "context-db-subnet-group"
  }
}

resource "aws_security_group" "context_db" {
  name        = "context-db-sg"
  description = "Security group for Context RDS Postgres"
  vpc_id      = var.vpc_id

  ingress {
    description = "PostgreSQL from allowed CIDRs"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidrs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "context-db-sg"
  }
}

resource "aws_db_instance" "context" {
  identifier = "context-db"

  engine         = "postgres"
  engine_version = "15.10"
  instance_class = "db.t4g.micro"

  allocated_storage = 20
  storage_type      = "gp2"

  db_name  = var.db_name
  username = var.db_user
  password = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.context.name
  vpc_security_group_ids = [aws_security_group.context_db.id]

  publicly_accessible = true

  backup_retention_period = 1
  backup_window           = "03:00-04:00"
  maintenance_window      = "Mon:04:00-Mon:05:00"

  skip_final_snapshot = true

  tags = {
    Name = "context-db"
  }
}

output "db_endpoint" {
  description = "RDS instance endpoint"
  value       = aws_db_instance.context.endpoint
}

output "db_port" {
  description = "RDS instance port"
  value       = aws_db_instance.context.port
}
