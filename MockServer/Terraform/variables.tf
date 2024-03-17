# variable "vpc_cidr_block" {
#   description = "The CIDR block for the VPC."
#   type        = string
#   default = "172.31.0.0/16"
# }

# variable "create_vpc" {
#   description = "Boolean to determine if a new VPC should be created."
#   type        = bool
#   default = false
# }

variable "cluster_name" {
  description = "The name of the EKS Cluster."
  type        = string
  default = "back-end-dev"
}

variable "existing_vpc_id" {
  description = "The ID of an existing VPC to use."
  type        = string
  default     = "vpc-88bddeee"
}

variable "existing_subnet_ids" {
  description = "The subnet IDs of the existing VPC."
  type        = list(string)
  default     = ["subnet-0652268e9cd2ce569", "subnet-02a8e4d016a7bd7b2"]
}

# variable "mockserver_namespace" {
#   description = "Namespace of mockserver in Kubernetes"
#   type = string
#   default = "mockserver"
# }

# variable "mockserver_docker_image" {
#   description = "Image of the mockserver container"
#   type = string
#   default = "069931004485.dkr.ecr.eu-west-1.amazonaws.com/mockserver:1.0.2"
# }

# Add other global variables here
