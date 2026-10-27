resource "aws_iam_policy" "eks_admin_policy" {
  name        = "AmazonEKSAdminPolicy"
  path        = "/"
  description = "Admin policy for managing EKS clusters and worker nodes."

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "eks:*",
          "ec2:DescribeInstances",
          "ec2:DescribeNetworkInterfaces",
          "ec2:DescribeSubnets",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeKeyPairs",
          "iam:PassRole",
          "iam:GetRole",
          "iam:CreateServiceLinkedRole",
          "autoscaling:DescribeAutoScalingGroups",
          "cloudformation:*",
        ]
        Resource = "*"
      }
    ]
  })
}



resource "aws_iam_role" "eks_administrator_access" {
  name = "EKSAdministratorAccess"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "Statement1"
        Effect    = "Allow"
        Principal = { "Service" : "eks.amazonaws.com" }
        Action    = "sts:AssumeRole"
      },
    ]
  })
}