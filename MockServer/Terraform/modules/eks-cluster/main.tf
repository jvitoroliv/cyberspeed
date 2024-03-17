resource "aws_eks_cluster" "cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids              = var.subnet_ids
    endpoint_public_access  = false
    endpoint_private_access = true
    security_group_ids      = [aws_security_group.eks_cluster_sg.id]
  }
}

# Security Group for EKS Cluster
resource "aws_security_group" "eks_cluster_sg" {
  name        = "eks-cluster-sg"
  description = "Security group for EKS cluster"
  vpc_id      = var.vpc_id

  tags = {
    Name = "eks-cluster-sg"
  }
}

# Inbound rule to allow all traffic for EKS Cluster Security Group
resource "aws_security_group_rule" "eks_cluster_inbound_all" {
  type        = "ingress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"  # -1 represents all protocols
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.eks_cluster_sg.id
}