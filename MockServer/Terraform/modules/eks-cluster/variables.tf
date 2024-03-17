variable "cluster_name" {
  description = "The name of the EKS Cluster."
  type        = string
}

variable "subnet_ids" {
  description = "The subnet IDs for the EKS Cluster."
  type        = list(string)
}

variable "vpc_id" {
  description = "The VPC ID where the EKS cluster will be created."
  type        = string
}