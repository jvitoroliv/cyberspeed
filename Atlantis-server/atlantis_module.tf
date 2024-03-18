module "atlantis" {
  source  = "terraform-aws-modules/atlantis/aws"
  version = "4.2.2"

  name = "atlantis-server"

  # ECS Container Definition
  atlantis = {
    environment = [
      {
        name  = "ATLANTIS_GH_USER"
        value = "jvitoroliv"
      },
      {
        name  = "ATLANTIS_REPO_ALLOWLIST"
        value = "github.com/jvitoroliv/cyberspeed"
      },
      {
        name  = "ATLANTIS_WEB_BASIC_AUTH"
        value = true
      },
      {
        name  = "ATLANTIS_WEB_USERNAME"
        value = "jvitoroliv"
      },
    ]
    secrets = [
      {
        name      = "ATLANTIS_WEB_PASSWORD"
        valueFrom = "arn:aws:ssm:us-east-1:851725424717:parameter/projects/cyberspeed/github/atlantis/server/password"
      },
      {
        name      = "ATLANTIS_GH_TOKEN"
        valueFrom = "arn:aws:ssm:us-east-1:851725424717:parameter/projects/cyberspeed/github/atlantis/token"
      },
      {
        name      = "ATLANTIS_GH_WEBHOOK_SECRET"
        valueFrom = "arn:aws:ssm:us-east-1:851725424717:parameter/projects/cyberspeed/github/atlantis/webhook/secret"
      },
    ]
  }

  # ECS Service
  service = {
    task_exec_secret_arns = [
      "arn:aws:ssm:us-east-1:851725424717:parameter/projects/cyberspeed/github/atlantis/server/password",
      "arn:aws:ssm:us-east-1:851725424717:parameter/projects/cyberspeed/github/atlantis/token",
      "arn:aws:ssm:us-east-1:851725424717:parameter/projects/cyberspeed/github/atlantis/webhook/secret",
    ]
    # Provide Atlantis permission necessary to create/destroy resources
    tasks_iam_role_policies = {
      AdministratorAccess = "arn:aws:iam::aws:policy/AdministratorAccess"
    }
  }
  service_subnets = ["subnet-06dca1d8bffee5f25", "subnet-0fa2b088e26f00cd7", "subnet-09e2239b804ea25b3"]
  vpc_id          = "vpc-0f145f4ffb81cac84"

  # ALB
  alb_subnets             = ["subnet-061a97f1949cb7e75", "subnet-0571306831cbe0d52", "subnet-0cb00a92d3d655662"]
  certificate_domain_name = "jvitoroliv.com"
  route53_zone_id         = "Z05958163ZDLQY6WQJ7N"

  tags = {
    Environment = "dev"
    Project     = "Cyberspeed Test"
    Terraform   = "true"
  }
}