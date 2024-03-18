module "vpc" {
  source          = "./modules/vpc"
  region          = var.region
  cidr            = var.cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
}

module "security" {
  source              = "./modules/security"
  cluster_name        = var.cluster_name
  vpc_id              = module.vpc.vpc_id
  eks_port_from       = var.eks_port
  eks_port_to         = var.eks_port
  allowed_cidr_blocks = var.allowed_cidr_blocks
}

module "eks" {
  source                      = "./modules/eks"
  region                      = var.region
  cluster_name                = var.cluster_name
  subnet_ids                  = module.vpc.private_subnets
  node_group_desired_capacity = var.node_group_desired_capacity
  node_group_max_capacity     = var.node_group_max_capacity
  node_group_min_capacity     = var.node_group_min_capacity
  node_group_ami_type         = var.node_group_ami_type
  node_group_instance_types   = var.node_group_instance_types
  node_group_max_unavailable  = var.node_group_max_unavailable
  aws_iam_role_cluster_arn    = module.security.aws_iam_role_cluster_arn
  aws_iam_role_node_group_arn = module.security.aws_iam_role_node_group_arn

  depends_on = [
    module.vpc,
    module.security,
  ]
}

module "ecr" {
  source = "./modules/ecr"
  // ... other variables
}

module "ssm" {
  source = "./modules/ssm"
  // ... other variables
}

module "networking" {
  source = "./modules/networking"
  // ... other variables
}