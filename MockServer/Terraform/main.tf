# # Conditional VPC Creation
# module "vpc_new" {
#   source     = "./modules/vpc"
#   cidr_block = var.vpc_cidr_block

#   count = var.create_vpc ? 1 : 0
# }

# module "vpc_existing" {
#   source  = "./modules/vpc"
#   vpc_id  = var.existing_vpc_id

#   count = var.create_vpc ? 0 : 1
# }

# EKS Cluster using the existing VPC
module "eks_cluster" {
  source       = "./modules/eks-cluster"
  cluster_name = var.cluster_name
  vpc_id       = var.existing_vpc_id
  subnet_ids   = var.existing_subnet_ids
}

module "asg_nodes" {
  source                 = "./modules/asg-nodes"
  cluster_name           = var.cluster_name
  vpc_id                 = var.existing_vpc_id
  subnet_ids             = var.existing_subnet_ids
  eks_cluster_dependency = module.eks_cluster.cluster
}

# module "container_deployment" {
#   source       = "./modules/container-deployment"
#   namespace    = var.mockserver_namespace
#   docker_image = var.mockserver_docker_image
#   cluster_name = var.cluster_name

#   depends_on = [module.eks_cluster, null_resource.delay]
# }

# resource "null_resource" "delay" {
#   depends_on = [module.asg_nodes]

#   provisioner "local-exec" {
#     command = "sleep 120"  # 120 seconds delay
#   }
# }