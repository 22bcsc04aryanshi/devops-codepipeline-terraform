variable "aws_region" {
  description = "AWS region to deploy to"
  default     = "ap-south-1"
}

variable "s3_bucket_name" {
  description = "S3 bucket to store artifacts"
  default     = "devops-codepipeline-bucket-aryanshi123"  # Make this unique
}

variable "github_repo" {
  description = "GitHub repo URL"
  default     = "https://github.com/22bcsc04aryanshi/devops-codepipeline-terraform"
}

variable "github_token" {
  description = "GitHub Personal Access Token for CodePipeline access"
  type        = string
  sensitive   = true
}
