locals {
  env = var.environment
  bucket_name = "terraform-bucket7733-${var.environment}"
  vpc_name = "${var.environment}-VPC"
  region = var.region
}
