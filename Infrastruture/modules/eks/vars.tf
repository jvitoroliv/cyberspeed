variable "cluster_name" {
  type = string
}

variable "cluster_version" {
  type = string
}

variable "cluster_endpoint_public_access" {
  type = bool
}

variable "cluster_addons-coredns" {
  type = bool
}

variable "cluster_addons-kube-proxy" {
  type = bool
}

variable "cluster_addons-vpc-cni" {
  type = bool
}

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "control_plane_subnet_ids" {
  type = list(string)
}

variable "eks_managed_ng-instance_types" {
  type = list(string)
}

variable "eks_managed_ng-name" {
  type = string
}

variable "eks_managed_ng-min_size" {
  type = number
}

variable "eks_managed_ng-max_size" {
  type = number
}

variable "eks_managed_ng-desired_size" {
  type = number
}

variable "eks_managed_ng-instace_types" {
  type = list(string)
}

variable "eks_managed_ng-capacity_type" {
  type = string
}

variable "enable_cluster_creator_admin_permissions" {
  type = bool
}

variable "access_entries_eks_admin" {
  type = string
}

variable "eks_admin_policy" {
  type = string
}

variable "tags" {
  type = map(string)
}