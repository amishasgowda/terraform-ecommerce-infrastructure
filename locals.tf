locals {
  bucket_name = "${var.project_name}-${var.environment}-product-assets-amisha"

  common_tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}