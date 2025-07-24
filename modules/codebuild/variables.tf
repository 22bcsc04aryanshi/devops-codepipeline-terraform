variable "codebuild_role_arn" {
  description = "IAM role ARN for CodeBuild"
}

variable "artifact_bucket" {
  description = "S3 bucket to store build output"
}

variable "github_repo" {
  description = "GitHub repository URL"
}
