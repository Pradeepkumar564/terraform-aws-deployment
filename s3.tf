#checkov:skip=CKV2_AWS_62:Event notifications are not required for this project.
#checkov:skip=CKV_AWS_18:Access logging is omitted to avoid additional storage costs.
#checkov:skip=CKV_AWS_144:Cross-region replication is omitted to avoid additional resource costs.
#checkov:skip=CKV_AWS_145:SSE-S3 encryption is used to avoid requiring a separately managed KMS key.
resource "aws_s3_bucket" "app" {
  bucket_prefix = "guvi-project03-app-"

  tags = {
    Name        = "GUVI Project 03 Application Bucket"
    Environment = var.environment
  }
}

resource "aws_s3_bucket_versioning" "app" {
  bucket = aws_s3_bucket.app.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "app" {
  bucket = aws_s3_bucket.app.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "app" {
  bucket = aws_s3_bucket.app.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}


resource "aws_s3_bucket_lifecycle_configuration" "app" {
  bucket = aws_s3_bucket.app.id

  rule {
    id     = "expire-noncurrent-versions"
    status = "Enabled"

    filter {}

    noncurrent_version_expiration {
      noncurrent_days = 30
    }
  }

  rule {
    id     = "abort-incomplete-multipart-uploads"
    status = "Enabled"

    filter {}

    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }
  }
}

