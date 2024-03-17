output "cluster_endpoint" {
  value = aws_eks_cluster.cluster.endpoint
}

output "cluster" {
  description = "EKS Cluster"
  value       = aws_eks_cluster.cluster
}

# output "cluster_identity_oidc_issuer" {
#   value = length(aws_eks_cluster.cluster.identity) > 0 ? tolist([for identity in aws_eks_cluster.cluster.identity : identity.oidc.issuer if identity.oidc != null])[0] : ""
# }
