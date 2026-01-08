variable "region" {
  description = "AWS region for RDS deployment"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where RDS will be deployed"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the DB subnet group"
  type        = list(string)
}

variable "db_name" {
  description = "Name of the database to create"
  type        = string
}

variable "db_user" {
  description = "Master username for the database"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Master password for the database"
  type        = string
  sensitive   = true
}

variable "allowed_cidrs" {
  description = "List of CIDR blocks allowed to connect to the database"
  type        = list(string)
}
