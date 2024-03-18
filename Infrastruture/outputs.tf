###### Network Module ######
output "vpc" {
  value = module.network.vpc.id
}

output "private_subnet_1a" {
  value = module.network.private_subnet_1a.id
}

output "private_subnet_1b" {
  value = module.network.private_subnet_1b.id
}

output "private_subnet_1c" {
  value = module.network.private_subnet_1c.id
}

output "public_subnet_1a" {
  value = module.network.public_subnet_1a.id
}

output "public_subnet_1b" {
  value = module.network.public_subnet_1b.id
}

output "public_subnet_1c" {
  value = module.network.public_subnet_1c.id
}


##### EKS Module ######
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