################################################################################
# Frontend - S3 + CloudFront (SPA)
################################################################################

module "frontend" {
  source = "../../modules/frontend"

  environment = local.environment
  bucket_name = "${local.project}-${local.environment}-frontend"

  versioning_enabled  = var.frontend_versioning_enabled
  price_class         = var.frontend_price_class
  enable_ipv6         = var.frontend_enable_ipv6
  default_root_object = var.frontend_default_root_object

  tags = local.common_tags
}
