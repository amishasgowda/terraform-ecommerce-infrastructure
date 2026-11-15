terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# S3 Bucket using the local name and common tags
resource "aws_s3_bucket" "product_assets" {
  bucket = local.bucket_name

  tags = local.common_tags
}

# IAM Policy referencing the S3 bucket ARN
resource "aws_iam_policy" "product_assets_access" {
  name = "${var.project_name}-${var.environment}-product-assets-access"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["s3:GetObject", "s3:PutObject"]
        Resource = "${aws_s3_bucket.product_assets.arn}/*"
      }
    ]
  })

  tags = local.common_tags
}