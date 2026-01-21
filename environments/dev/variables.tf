################################################################################
# Development Environment Variables
################################################################################

variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "eu-west-2"
}

################################################################################
# Networking Variables
################################################################################

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.10.0/24", "10.0.11.0/24"]
}

################################################################################
# S3 Variables
################################################################################

variable "s3_versioning_enabled" {
  description = "Enable versioning for S3 bucket"
  type        = bool
  default     = true
}

variable "glacier_transition_days" {
  description = "Days before transitioning to Glacier"
  type        = number
  default     = 90
}

################################################################################
# RDS Variables
################################################################################

variable "db_name" {
  description = "Name of the PostgreSQL database"
  type        = string
  default     = "contextdb"
}

variable "db_username" {
  description = "Master username for RDS"
  type        = string
  default     = "postgres"
}

variable "db_password" {
  description = "Master password for RDS (pass via TF_VAR_db_password env var)"
  type        = string
  sensitive   = true
}

variable "rds_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "rds_allocated_storage" {
  description = "Allocated storage in GB"
  type        = number
  default     = 20
}

variable "postgres_version" {
  description = "PostgreSQL version (15+ for pgvector)"
  type        = string
  default     = "15"
}

variable "rds_multi_az" {
  description = "Enable Multi-AZ for RDS"
  type        = bool
  default     = false
}

################################################################################
# Bastion Variables
################################################################################

variable "bastion_ssh_public_key" {
  description = "SSH public key for bastion access (contents of ~/.ssh/id_rsa.pub)"
  type        = string
}

variable "my_ip_cidr" {
  description = "Your IP address in CIDR format for SSH access (e.g., 1.2.3.4/32)"
  type        = string
}

################################################################################
# GitHub Actions OIDC Variables
################################################################################

variable "github_repo_name" {
  description = "The GitHub repository allowed to assume the IAM role (format: username/repo)"
  type        = string
}
