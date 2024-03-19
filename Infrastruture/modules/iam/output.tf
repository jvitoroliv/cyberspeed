output "cluster_role" {
  value = aws_iam_role.eks_cluster_role
}

output "lb_controller_policy" {
  value = aws_iam_policy.policy
}

output "eks_administrator_role" {
  value = aws_iam_role.eks_administrator_access
}