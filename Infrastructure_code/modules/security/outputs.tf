output "aws_iam_role_cluster_arn" {
  value = aws_iam_role.cluster.arn
}

output "aws_iam_role_node_group_arn" {
  value = aws_iam_role.node_group.arn
}