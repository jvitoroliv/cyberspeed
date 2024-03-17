resource "aws_eks_node_group" "node_group" {
  cluster_name    = var.cluster_name
  node_group_name = "eks-node-group"
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = var.subnet_ids

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  tags = {
    Name = "${var.cluster_name}-Node-Group"
  }

  depends_on = [var.eks_cluster_dependency]
  # Add other configurations like instance types, disk size, etc.
}