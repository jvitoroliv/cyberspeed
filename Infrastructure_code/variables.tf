variable "region" {
  description = "The AWS region to create resources in"
  default     = "us-east-1"
}

# EKS Module Variables
variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
  default     = "cyberspeed-project"
}

variable "subnet_ids" {
  description = "A list of subnet IDs for the EKS cluster"
  type        = list(string)
}

variable "node_group_desired_capacity" {
  description = "The desired capacity of the node group"
  type        = number
}

variable "node_group_max_capacity" {
  description = "The maximum capacity of the node group"
  type        = number
}

variable "node_group_min_capacity" {
  description = "The minimum capacity of the node group"
  type        = number
}

variable "node_group_ami_type" {
  description = "The type of AMI used for the nodes"
  type        = string
  default     = "AL2_x86_64"
}

variable "node_group_instance_types" {
  description = "The instance types to use for the nodes in the node group"
  type        = list(string)
  default     = ["t3.medium"]
}

variable "node_group_max_unavailable" {
  description = "The maximum number of nodes that can be unavailable during updates"
  type        = number
  default     = 1
}


# VPC Module Variables
variable "cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

# Security Module Variables
variable "eks_port" {
  description = "The port on which the EKS cluster is running"
  type        = number
  default     = 443
}

variable "allowed_cidr_blocks" {
  description = "CIDR blocks that are allowed to access the EKS cluster"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
