variable "ec2_ami" {
  description = "AMI ID to launch EC2 instance"
}

variable "ec2_key_pair" {
  description = "EC2 key pair name"
}

variable "codedeploy_role_arn" {
  description = "IAM Role ARN for CodeDeploy"
}

variable "aws_region" {
  description = "AWS Region"
}
