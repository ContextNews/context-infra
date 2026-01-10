################################################################################
# Bastion Module Variables
################################################################################

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "public_subnet_id" {
  description = "ID of the public subnet for bastion placement"
  type        = string
}

variable "ssh_public_key" {
  description = "SSH public key for bastion access (contents of ~/.ssh/id_rsa.pub)"
  type        = string
}

variable "allowed_ip_cidr" {
  description = "CIDR block allowed to SSH into bastion (e.g., your home IP: 1.2.3.4/32)"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for bastion"
  type        = string
  default     = "t3.micro"
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
