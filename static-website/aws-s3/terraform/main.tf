module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "static-public-s3-bucket"
  acl    = "private"

  control_object_ownership = true
  object_ownership         = "ObjectWriter"
  force_destroy            = true

  versioning = {
    enabled = false
  }

  website = {
    index_document = "index.html"
  }

  block_public_acls       = true 
  block_public_policy     = false
  ignore_public_acls      = true
  restrict_public_buckets = false

  attach_policy = true
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = "*"
      Action = "s3:GetObject"
      Resource = "arn:aws:s3:::static-public-s3-bucket/*"
    }]
  })
}

resource "aws_s3_object" "index" {
  bucket       = module.s3_bucket.s3_bucket_id
  key          = "index.html"
  source       = "${path.module}/site/index.html"
  content_type = "text/html"
  etag         = filemd5("${path.module}/site/index.html")
}
