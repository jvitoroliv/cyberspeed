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