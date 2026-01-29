################################################################################
# IAM GitHub OIDC Module Variables
################################################################################

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
}

variable "github_repo_subs" {
  description = "List of GitHub OIDC subject claims allowed to assume the role"
  type        = list(string)
}

variable "s3_bucket_arn" {
  description = "ARN of the S3 bucket to grant access to"
  type        = string
}

variable "frontend_bucket_arn" {
  description = "ARN of the S3 bucket for frontend deployments"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
