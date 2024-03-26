locals {
  aws_auth_role     = "arn:aws:iam::{AWS::ACCOUNT::ID}:role/{ROLE_EKSAdministratorAccess}"
  aws_auth_username = "EKSAdminUsers"
  aws_account_id    = data.aws_caller_identity.current.account_id
  user_arn          = "arn:aws:iam::{AWS::ACCOUNT::ID}:user/{USER}"
  user_name         = "{USER_NAME}"
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

###### EKS vars ######
variable "cluster_name" {
  type    = string
  default = "cyberspeed-assessment"
}

variable "cluster_version" {
  type    = string
  default = "1.29"
}

variable "cluster_endpoint_public_access" {
  type    = bool
  default = true
}

variable "cluster_addons-coredns" {
  type    = bool
  default = true
}

variable "cluster_addons-kube-proxy" {
  type    = bool
  default = true
}

variable "cluster_addons-vpc-cni" {
  type    = bool
  default = true
}

variable "eks_managed_ng-instance_types" {
  type    = list(string)
  default = ["m6i.large", "m5.large", "m5n.large", "m5zn.large", "t3.medium", "t3.large"]
}

variable "eks_managed_ng-name" {
  type    = string
  default = "eks_t3m_ng"
}

variable "eks_managed_ng-min_size" {
  type    = number
  default = 1
}

variable "eks_managed_ng-max_size" {
  type    = number
  default = 5
}

variable "eks_managed_ng-desired_size" {
  type    = number
  default = 3
}

variable "eks_managed_ng-instace_types" {
  type    = list(string)
  default = ["t3.large"]
}

variable "eks_managed_ng-capacity_type" {
  type    = string
  default = "ON_DEMAND"
}

variable "enable_cluster_creator_admin_permissions" {
  type    = bool
  default = true
}

variable "access_entries_eks_admin" {
  type    = string
  default = "cluster-admin"
}

###### SSM Parameters vars ######
variable "ssm_secret_database_name" {
  type    = string
  default = "/projects/cyberspeed/database/password/master"
}
