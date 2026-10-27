###### Network Module ######
output "vpc" {
  value = module.network.vpc.id
}

output "private_subnet_1a" {
  value = module.network.private_subnet_1a
}

output "private_subnet_1b" {
  value = module.network.private_subnet_1b
}

output "private_subnet_1c" {
  value = module.network.private_subnet_1c
}

output "public_subnet_1a" {
  value = module.network.public_subnet_1a
}

output "public_subnet_1b" {
  value = module.network.public_subnet_1b
}

output "public_subnet_1c" {
  value = module.network.public_subnet_1c
}

###### IAM Module ######
output "cluster_role" {
  value = module.iam.cluster_role.arn
}

output "lb_controller_policy" {
  value = module.iam.lb_controller_policy.arn
}

output "eks_administrator_role" {
  value = module.iam.eks_administrator_role
}


# ##### EKS Module ######
output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "cluster_certificate_authority_data" {
  value = module.eks.cluster_certificate_authority_data
}

output "cluster_id" {
  value = module.eks.cluster_id
}

output "cluster" {
  value = module.eks
}

output "self_managed_node_groups" {
  value = module.eks.self_managed_node_groups
}