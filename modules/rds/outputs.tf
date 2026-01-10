################################################################################
# RDS Module Outputs
################################################################################

output "db_instance_id" {
  description = "The ID of the RDS instance"
  value       = aws_db_instance.postgres.id
}

output "db_instance_identifier" {
  description = "The identifier of the RDS instance"
  value       = aws_db_instance.postgres.identifier
}

output "db_endpoint" {
  description = "The connection endpoint for the RDS instance"
  value       = aws_db_instance.postgres.endpoint
}

output "db_address" {
  description = "The hostname of the RDS instance"
  value       = aws_db_instance.postgres.address
}

output "db_port" {
  description = "The port of the RDS instance"
  value       = aws_db_instance.postgres.port
}

output "db_name" {
  description = "The name of the database"
  value       = aws_db_instance.postgres.db_name
}

output "db_username" {
  description = "The master username for the database"
  value       = aws_db_instance.postgres.username
  sensitive   = true
}

output "db_arn" {
  description = "The ARN of the RDS instance"
  value       = aws_db_instance.postgres.arn
}
