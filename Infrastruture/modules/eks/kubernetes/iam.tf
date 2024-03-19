resource "aws_iam_role" "sa_role" {
  name = format("%s-service-account-ServiceRole", var.cluster_name)

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::${var.aws_account}:oidc-provider/${var.oidc_provider}"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
        "Condition": {
          "StringEquals": {
            "${var.oidc_provider}:aud": "sts.amazonaws.com",
            "${var.oidc_provider}:sub": "system:serviceaccount:kube-system:aws-load-balancer-controller"
        }
      }
    }
  ]
}
POLICY

}

resource "aws_iam_role_policy_attachment" "eks_load-balancer-controller" {
  policy_arn = "arn:aws:iam::${var.aws_account}:policy/AWSLoadBalancerControllerIAMPolicy"
  role       = aws_iam_role.sa_role.name
}