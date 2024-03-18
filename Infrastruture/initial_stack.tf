module "network" {
  source = "./modules/network"

  aws_region   = var.aws_region
  vpc_name     = var.vpc_name
  cidr_block   = var.cidr_block
  cluster_name = var.cluster_name
}

module "cluster" {
  source = "./modules/eks/cluster"

  vpc_id       = module.network.vpc.id
  cluster_name = var.cluster_name

  depends_on = [ module.network ]
}