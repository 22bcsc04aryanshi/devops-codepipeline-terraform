provider "aws" {
  region = var.aws_region
}

module "s3" {
  source      = "./modules/s3"
  bucket_name = var.s3_bucket_name
}

module "iam" {
  source = "./modules/iam"
}

module "codebuild" {
  source             = "./modules/codebuild"
  codebuild_role_arn = module.iam.codebuild_role_arn
  artifact_bucket    = module.s3.bucket_name
  github_repo        = var.github_repo
}


module "codedeploy" {
  source             = "./modules/codedeploy"
  ec2_ami            = "ami-0f5ee92e2d63afc18"   #  Amazon Linux 2 AMI (ap-south-1)
  ec2_key_pair       = "devops-key"           #  Replace with your actual EC2 Key Pair name
  codedeploy_role_arn = module.iam.codedeploy_role_arn
  aws_region         = var.aws_region
}


module "codepipeline" {
  source                     = "./modules/codepipeline"
  codepipeline_role_arn      = module.iam.codepipeline_role_arn
  artifact_bucket            = var.s3_bucket_name
  github_owner               = "22bcsc04aryanshi"
  github_repo_name           = "devops-codepipeline-terraform"
  github_branch              = "main"
  github_token               = var.github_token
  codebuild_project_name     = module.codebuild.project_name
  codedeploy_app_name        = module.codedeploy.application_name
  codedeploy_deployment_group = module.codedeploy.deployment_group_name
}
