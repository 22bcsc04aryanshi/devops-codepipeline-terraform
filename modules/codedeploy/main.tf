resource "aws_instance" "app_server" {
  ami           = var.ec2_ami
  instance_type = "t2.micro"
  key_name      = var.ec2_key_pair
  iam_instance_profile = aws_iam_instance_profile.codedeploy_profile.name

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y ruby wget
              cd /home/ec2-user
              wget https://aws-codedeploy-${var.aws_region}.s3.${var.aws_region}.amazonaws.com/latest/install
              chmod +x ./install
              sudo ./install auto
              sudo service codedeploy-agent start
              EOF

  tags = {
    Name = "CodeDeployEC2Instance"
  }
}

resource "aws_iam_role" "codedeploy_ec2_role" {
  name = "CodeDeployEC2Role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ec2_codedeploy_policy" {
  role       = aws_iam_role.codedeploy_ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforAWSCodeDeploy"
}

resource "aws_iam_instance_profile" "codedeploy_profile" {
  name = "CodeDeployEC2InstanceProfile"
  role = aws_iam_role.codedeploy_ec2_role.name
}

resource "aws_codedeploy_app" "app" {
  name = "DevOpsApp"
  compute_platform = "Server"
}

resource "aws_codedeploy_deployment_group" "deployment_group" {
  app_name              = aws_codedeploy_app.app.name
  deployment_group_name = "DevOpsDeploymentGroup"
  service_role_arn      = var.codedeploy_role_arn

  deployment_style {
    deployment_type = "IN_PLACE"
    deployment_option = "WITHOUT_TRAFFIC_CONTROL"
  }

  ec2_tag_filter {
    key   = "Name"
    type  = "KEY_AND_VALUE"
    value = "CodeDeployEC2Instance"
  }

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }
}
