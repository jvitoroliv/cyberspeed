locals {
  aws_auth_role       = "arn:aws:iam::{AWS::ACCOUNT::ID}:role/{ROLE_EKSAdministratorAccess}"
  aws_auth_username   = "EKSAdminUsers"
  aws_account_id      = data.aws_caller_identity.current.account_id
  user_arn  = "arn:aws:iam::{AWS::ACCOUNT::ID}:user/{USER}"
  user_name = "{USER_NAME}"
}

data "aws_caller_identity" "current" {}

###### Shared vars ######
variable "aws_region" {
  default = "us-east-1"
}
variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default = {
    "Project"              = ""
    "Environment"          = ""
    "Owner"                = ""
    "Managed_by_Terraform" = "true"
  }
}

###### Network vars ######
variable "vpc_name" {
  default = "VPC_NAME"
}
variable "cidr_block" {
  default = "10.1"
}


###### Cluster vars ######
variable "cluster_name" {
  default = "EKS_CLUSTER_NAME"
}
variable "k8s_version" {
  default = "1.27"
}

###### Node vars ######
variable "node_instances_type" {
  default = "t3.medium"
}
variable "scaling_config_max_size" {
  default = 5
}
variable "scaling_config_min_size" {
  default = 1
}
variable "scaling_config_desired_size" {
  default = 3
}

###### Kubernetes vars ######
variable "namespace" {
  default = "applications"
}