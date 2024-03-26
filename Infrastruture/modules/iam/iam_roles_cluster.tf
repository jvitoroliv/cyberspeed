resource "aws_iam_role" "eks_cluster_role" {
  name = format("%s-cluster-ServiceRole", var.cluster_name)

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": [
        "sts:AssumeRole",
        "sts:AssumeRoleWithWebIdentity"
      ]
    }
  ]
}
POLICY

}