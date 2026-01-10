################################################################################
# Development Environment - Main Configuration
################################################################################

terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Uncomment and configure for remote state
  # backend "s3" {
  #   bucket         = "your-terraform-state-bucket"
  #   key            = "context-infra/dev/terraform.tfstate"
  #   region         = "eu-west-2"
  #   encrypt        = true
  #   dynamodb_table = "terraform-state-lock"
  # }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "context-infra"
      Environment = "dev"
      ManagedBy   = "terraform"
    }
  }
}

################################################################################
# Local Values
################################################################################

locals {
  environment = "dev"
  project     = "context"

  common_tags = {
    Project     = local.project
    Environment = local.environment
    ManagedBy   = "terraform"
  }
}

################################################################################
# Networking Module
################################################################################

module "networking" {
  source = "../../modules/networking"

  environment          = local.environment
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidr   = var.public_subnet_cidr
  private_subnet_cidrs = var.private_subnet_cidrs

  tags = local.common_tags
}

################################################################################
# S3 Module - Data Storage
################################################################################

module "s3_data" {
  source = "../../modules/s3"

  environment             = local.environment
  bucket_name             = "${local.project}-${local.environment}-data-uk"
  versioning_enabled      = var.s3_versioning_enabled
  glacier_transition_days = var.glacier_transition_days

  tags = local.common_tags
}

################################################################################
# RDS Module - PostgreSQL with pgvector
################################################################################

module "rds" {
  source = "../../modules/rds"

  environment          = local.environment
  db_name              = var.db_name
  db_username          = var.db_username
  db_password          = var.db_password
  instance_class       = var.rds_instance_class
  allocated_storage    = var.rds_allocated_storage
  engine_version       = var.postgres_version
  multi_az             = var.rds_multi_az
  db_subnet_group_name = module.networking.db_subnet_group_name
  security_group_id    = module.networking.rds_security_group_id

  # Dev-specific settings
  deletion_protection = false
  skip_final_snapshot = true

  tags = local.common_tags
}
