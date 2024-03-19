module "eks" {
  source = "./modules/eks"

  cluster_name                             = var.cluster_name
  cluster_version                          = var.cluster_version
  cluster_endpoint_public_access           = var.cluster_endpoint_public_access
  cluster_addons-coredns                   = var.cluster_addons-coredns
  cluster_addons-kube-proxy                = var.cluster_addons-kube-proxy
  cluster_addons-vpc-cni                   = var.cluster_addons-vpc-cni
  vpc_id                                   = module.network.vpc.id
  subnet_ids                               = [module.network.private_subnet_1a, module.network.private_subnet_1b, module.network.private_subnet_1c]
  control_plane_subnet_ids                 = [module.network.public_subnet_1a, module.network.public_subnet_1b, module.network.public_subnet_1c]
  eks_managed_ng-instance_types            = var.eks_managed_ng-instance_types
  eks_managed_ng-name                      = var.eks_managed_ng-name
  eks_managed_ng-min_size                  = var.eks_managed_ng-min_size
  eks_managed_ng-max_size                  = var.eks_managed_ng-max_size
  eks_managed_ng-desired_size              = var.eks_managed_ng-desired_size
  eks_managed_ng-instace_types             = var.eks_managed_ng-instace_types
  eks_managed_ng-capacity_type             = var.eks_managed_ng-capacity_type
  enable_cluster_creator_admin_permissions = var.enable_cluster_creator_admin_permissions
  access_entries_eks_admin                 = var.access_entries_eks_admin
  tags                                     = var.tags

  depends_on = [module.network, module.iam]
}