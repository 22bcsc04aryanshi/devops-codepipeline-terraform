variable "codepipeline_role_arn" {
  description = "IAM Role ARN for CodePipeline"
  type        = string
}

variable "artifact_bucket" {
  description = "S3 bucket for storing artifacts"
  type        = string
}

variable "github_owner" {
  description = "GitHub repo owner (username or org)"
  type        = string
}

variable "github_repo_name" {
  description = "Name of the GitHub repository"
  type        = string
}

variable "github_branch" {
  description = "GitHub branch to build from"
  type        = string
}

variable "github_token" {
  description = "GitHub OAuth token"
  type        = string
  sensitive   = true
}

variable "codebuild_project_name" {
  description = "Name of the AWS CodeBuild project"
  type        = string
}

variable "codedeploy_app_name" {
  description = "CodeDeploy application name"
  type        = string
}

variable "codedeploy_deployment_group" {
  description = "CodeDeploy deployment group name"
  type        = string
}
