resource "aws_codebuild_project" "app_build" {
  name          = "DevOpsCodeBuildProject"
  description   = "Build project for the pipeline"
  build_timeout = 10

  service_role  = var.codebuild_role_arn

  artifacts {
    type = "S3"
    location = var.artifact_bucket
    packaging = "ZIP"
    path = "build-output"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:5.0"
    type                        = "LINUX_CONTAINER"
    privileged_mode             = true
  }

  source {
    type            = "GITHUB"
    location        = var.github_repo
    git_clone_depth = 1
    buildspec       = "buildspec.yml"
  }

  tags = {
    Name = "CodeBuild"
  }
}
