locals {
  aws_auth_role       = "arn:aws:iam::851725424717:role/EKSAdministratorAccess"
  aws_auth_username   = "EKSAdminUsers"
  aws_account_id      = data.aws_caller_identity.current.account_id
  user_arn  = "arn:aws:iam::851725424717:user/cyberspeed"
  user_name = "cyberspeed-user"
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
    "Project"              = "Cyberspeed"
    "Environment"          = "Development"
    "Owner"                = "Joao_Vitor"
    "Managed_by_Terraform" = "true"
  }
}

###### Network vars ######
variable "vpc_name" {
  default = "cyberspeed-test"
}
variable "cidr_block" {
  default = "10.1"
}


###### Cluster vars ######
variable "cluster_name" {
  default = "cyberspeed-test"
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

# #Deployment vars
# variable "deploy_name" {}
# variable "args" {
#   type = list(string)
# }
# variable "command" {
#   type = list(string)
# }
# variable "image" {}
# variable "label" {}