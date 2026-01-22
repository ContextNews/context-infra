################################################################################
# Development Environment Outputs
################################################################################

################################################################################
# S3 Outputs (for Python pipeline)
################################################################################

output "s3_bucket_name" {
  description = "Name of the S3 data bucket"
  value       = module.s3_data.bucket_name
}

output "s3_bucket_arn" {
  description = "ARN of the S3 data bucket"
  value       = module.s3_data.bucket_arn
}

################################################################################
# RDS Outputs (for Python pipeline)
################################################################################

output "rds_endpoint" {
  description = "RDS PostgreSQL endpoint URL"
  value       = module.rds.db_endpoint
}

output "rds_address" {
  description = "RDS PostgreSQL hostname"
  value       = module.rds.db_address
}

output "rds_port" {
  description = "RDS PostgreSQL port"
  value       = module.rds.db_port
}

output "rds_database_name" {
  description = "Name of the PostgreSQL database"
  value       = module.rds.db_name
}

################################################################################
# Networking Outputs
################################################################################

output "vpc_id" {
  description = "ID of the VPC"
  value       = module.networking.vpc_id
}

output "private_subnet_ids" {
  description = "IDs of the private subnets"
  value       = module.networking.private_subnet_ids
}

output "public_subnet_id" {
  description = "ID of the public subnet"
  value       = module.networking.public_subnet_id
}

################################################################################
# Bastion Outputs
################################################################################

output "bastion_public_ip" {
  description = "Public IP address of the bastion host"
  value       = module.bastion.public_ip
}

output "bastion_ssh_command" {
  description = "SSH command to connect to bastion"
  value       = module.bastion.ssh_command
}

output "bastion_rds_tunnel_command" {
  description = "SSH tunnel command for local RDS access"
  value       = "ssh -i ~/.ssh/id_rsa -L 5432:${module.rds.db_address}:5432 ec2-user@${module.bastion.public_ip}"
}

################################################################################
# GitHub Actions OIDC Outputs
################################################################################

output "github_actions_role_arn" {
  description = "IAM Role ARN for GitHub Actions to assume"
  value       = module.iam_github.role_arn
}

################################################################################
# FastAPI Outputs
################################################################################

output "api_alb_dns_name" {
  description = "Public DNS name of the FastAPI ALB"
  value       = aws_lb.api.dns_name
}

output "ecr_repository_url" {
  description = "ECR repository URL for the FastAPI image"
  value       = aws_ecr_repository.context_api.repository_url
}

################################################################################
# Connection String Helper (for local development)
################################################################################

output "database_connection_info" {
  description = "Database connection information (password not included)"
  value = {
    host     = module.rds.db_address
    port     = module.rds.db_port
    database = module.rds.db_name
    username = "postgres"
    note     = "Use TF_VAR_db_password environment variable for password"
  }
}
