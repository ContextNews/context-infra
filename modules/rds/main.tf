################################################################################
# RDS Module - PostgreSQL with pgvector Support
################################################################################

################################################################################
# DB Parameter Group (for pgvector extension)
################################################################################

resource "aws_db_parameter_group" "postgres" {
  name        = "${var.environment}-postgres-params"
  family      = "postgres${var.engine_version}"
  description = "PostgreSQL parameter group for ${var.environment}"

  parameter {
    name  = "shared_preload_libraries"
    value = "pg_stat_statements"
  }

  tags = merge(var.tags, {
    Name = "${var.environment}-postgres-params"
  })
}

################################################################################
# RDS Instance
################################################################################

resource "aws_db_instance" "postgres" {
  identifier = "${var.environment}-${var.db_name}"

  # Engine Configuration
  engine               = "postgres"
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  parameter_group_name = aws_db_parameter_group.postgres.name

  # Storage Configuration
  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  storage_type          = var.storage_type
  storage_encrypted     = true

  # Database Configuration
  db_name  = var.db_name
  username = var.db_username
  password = var.db_password
  port     = 5432

  # Network Configuration
  db_subnet_group_name   = var.db_subnet_group_name
  vpc_security_group_ids = [var.security_group_id]
  publicly_accessible    = false
  multi_az               = var.multi_az

  # Backup Configuration
  backup_retention_period = var.backup_retention_period
  backup_window           = var.backup_window
  maintenance_window      = var.maintenance_window

  # Monitoring
  performance_insights_enabled          = var.performance_insights_enabled
  performance_insights_retention_period = var.performance_insights_enabled ? 7 : null

  # Deletion Protection
  deletion_protection       = var.deletion_protection
  skip_final_snapshot       = var.skip_final_snapshot
  final_snapshot_identifier = var.skip_final_snapshot ? null : "${var.environment}-${var.db_name}-final-snapshot"

  # Auto Minor Version Upgrade
  auto_minor_version_upgrade = true

  tags = merge(var.tags, {
    Name        = "${var.environment}-${var.db_name}"
    Environment = var.environment
  })
}
