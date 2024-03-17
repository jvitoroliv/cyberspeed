variable "cluster_name" {
  description = "The name of the EKS Cluster."
  type        = string
}

variable "subnet_ids" {
  description = "Subnet IDs where the node group should be created."
  type        = list(string)
}

variable "vpc_id" {
  description = "The VPC ID where the Auto Scaling Group nodes will be created."
  type        = string
}

variable "eks_cluster_dependency" {
  description = "Dependency on the EKS Cluster."
  type        = any
}