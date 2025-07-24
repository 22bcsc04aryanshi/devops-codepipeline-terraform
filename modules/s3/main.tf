resource "aws_s3_bucket" "artifacts" {
  bucket = var.bucket_name

  versioning {
    enabled = true
  }

  tags = {
    Name = "codepipeline-artifacts"
  }
}
