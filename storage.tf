resource "aws_s3_bucket" "storage" {
  bucket = var.s3_bucket_name

  tags = {
    Name   = var.s3_bucket_name
    Backup = "true"
  }
}

resource "aws_s3_bucket_ownership_controls" "storage_ownership" {
  bucket = aws_s3_bucket.storage.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "storage_acl" {
  depends_on = [aws_s3_bucket_ownership_controls.storage_ownership]

  bucket = aws_s3_bucket.storage.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "storage_versioning" {
  bucket = aws_s3_bucket.storage.id
  versioning_configuration {
    status = "Enabled"
  }
}
