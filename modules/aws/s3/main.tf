#-------------------------------------------------
#
# Create S3 Bucket - Module:
#   - Create
#
#-------------------------------------------------

# Create S3
resource "aws_s3_bucket" "this" {
  bucket = var.name
}

resource "aws_s3_bucket_ownership_controls" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    object_ownership = var.object_ownership
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = var.public_access_settings.block_public_acls
  block_public_policy     = var.public_access_settings.block_public_policy
  ignore_public_acls      = var.public_access_settings.ignore_public_acls
  restrict_public_buckets = var.public_access_settings.restrict_public_buckets
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = var.versioning_configuration_status
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "static" {
  bucket = aws_s3_bucket.this.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = true
  }
}