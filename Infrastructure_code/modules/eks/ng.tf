resource "aws_eks_node_group" "node_group" {
  cluster_name    = aws_eks_cluster.cluster.name
  node_group_name = "eks-node-group-${var.cluster_name}"
  node_role_arn   = var.aws_iam_role_node_group_arn
  subnet_ids      = var.subnet_ids

  scaling_config {
    desired_size = var.node_group_desired_capacity
    max_size     = var.node_group_max_capacity
    min_size     = var.node_group_min_capacity
  }

  ami_type             = var.node_group_ami_type
  instance_types       = var.node_group_instance_types
  force_update_version = true

  update_config {
    max_unavailable = var.node_group_max_unavailable
  }

  depends_on = [aws_eks_cluster.cluster]
}
