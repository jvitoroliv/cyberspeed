module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.8.3"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  cluster_endpoint_public_access = var.cluster_endpoint_public_access

  cluster_addons = {
    coredns = {
      most_recent = var.cluster_addons-coredns
    }
    kube-proxy = {
      most_recent = var.cluster_addons-kube-proxy
    }
    vpc-cni = {
      most_recent = var.cluster_addons-vpc-cni
    }
  }

  vpc_id                   = var.vpc_id
  subnet_ids               = var.subnet_ids
  control_plane_subnet_ids = var.control_plane_subnet_ids

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    instance_types = var.eks_managed_ng-instace_types
  }

  eks_managed_node_groups = {
    "${var.eks_managed_ng-name}" = {
      min_size     = var.eks_managed_ng-min_size
      max_size     = var.eks_managed_ng-max_size
      desired_size = var.eks_managed_ng-desired_size

      instance_types = var.eks_managed_ng-instace_types
      capacity_type  = var.eks_managed_ng-capacity_type
    }
  }

  # Cluster access entry
  # To add the current caller identity as an administrator
  enable_cluster_creator_admin_permissions = var.enable_cluster_creator_admin_permissions

  access_entries = {
    # One access entry with a policy associated
    "${var.access_entries_eks_admin}" = {
      kubernetes_groups = ["cluster-admin"]
      principal_arn     = "${var.eks_administrator_role}"
    }
  }

  tags = merge(var.tags)
  cluster_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "${var.cluster_name}"
  }
}