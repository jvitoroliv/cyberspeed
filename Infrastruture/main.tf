# module "eks" {
#   source  = "terraform-aws-modules/eks/aws"
#   version = "19.21.0"

#   ###### EKS Cluster ######

#   ###### Basic cluster properties ######
#   cluster_name    = var.cluster_name
#   cluster_version = var.k8s_version
#   iam_role_arn    = module.cluster.cluster_role.arn

#   ###### Cluster Network properties ######
#   vpc_id                          = module.network.vpc.id
#   subnet_ids                      = [
#     module.network.private_subnet_1a.id,
#     module.network.private_subnet_1b.id,
#     module.network.private_subnet_1c.id,
#     module.network.public_subnet_1a.id,
#     module.network.public_subnet_1b.id,
#     module.network.public_subnet_1c.id
#   ]
#   cluster_endpoint_private_access = true
#   cluster_endpoint_public_access  = true

#   ###### Extend cluster security group rules ######
#   cluster_security_group_additional_rules = {
#     egress_nodes_ephemeral_ports_tcp = {
#       description                = "To node 1025-65535"
#       protocol                   = "tcp"
#       from_port                  = 1025
#       to_port                    = 65535
#       type                       = "egress"
#       source_node_security_group = true
#     }
#   }

#   ###### Cluster addons ######
#   cluster_addons = {
#     coredns = {
#       resolve_conflicts = "OVERWRITE"
#     }
#     kube-proxy = {}
#     vpc-cni = {
#       resolve_conflicts_on_update = "OVERWRITE"
#     }
#   }

#   ###### Cluster logs ######
#   cluster_enabled_log_types = [
#     "api",
#     "audit",
#     "authenticator",
#     "controllerManager",
#     "scheduler",
#   ]
#   create_cloudwatch_log_group            = true
#   cloudwatch_log_group_retention_in_days = 3


#   ###### Self Managed Node Group Option ######
#   # Nodes
#   # # Self Managed Node Group(s)
#   # # Creates the default ground rules that all worker nodes must follow.
#   # self_managed_node_group_defaults = {
#   #   instance_type                          = "${var.node_instances_type}"
#   #   update_launch_template_default_version = true
#   #   subnet_ids                             = "${[[
#   #   module.network.private_subnet_1a.id,
#   #   module.network.private_subnet_1b.id,
#   #   module.network.private_subnet_1c.id,]}"
#   #   iam_role_additional_policies = [
#   #     "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
#   #     # "arn:aws:iam::910090332230:policy/AWSLoadBalancerControllerIAMPolicy"
#   #   ]
#   #   use_default_tags = true
#   # }
#   # # Self Managed Node Group
#   # # Create the nodegroup
#   # self_managed_node_groups = {
#   #   node_profile = {
#   #     name                       = format("%s-node", var.cluster_name)
#   #     min_size                   = "${var.scaling_config_min_size}"
#   #     max_size                   = "${var.scaling_config_max_size}"
#   #     desired_size               = "${var.scaling_config_desired_size}"
#   #     use_mixed_instances_policy = true
#   #     launch_template_tags       = "${merge(var.tags, var.ng-tags)}"
#   #     mixed_instances_policy = {
#   #       instances_distribution = {
#   #         on_demand_base_capacity                  = 0
#   #         on_demand_percentage_above_base_capacity = 10
#   #         spot_allocation_strategy                 = "capacity-optimized"
#   #       }

#   #       override = [
#   #         {
#   #           instance_type     = "${var.node_instances_type}"
#   #           weighted_capacity = "1"
#   #         }
#   #       ]
#   #     }
#   #   }
#   # }


#   ###### AWS Managed Node Group ######
#   eks_managed_node_group_defaults = {
#       disk_size      = 20
#       instance_types = ["m6i.large", "m5.large", "m5n.large", "m5zn.large", "t3.large", "t3.medium"]
#     }

#   eks_managed_node_groups = {
#     node_profile = {
#       name = "${format("%s-ng", var.cluster_name)}"
#       use_name_prefix = true

#       subnet_ids = "${[
#         module.network.private_subnet_1a.id,
#         module.network.private_subnet_1b.id,
#         module.network.private_subnet_1c.id]}"

#       min_size     = "${var.scaling_config_min_size}"
#       max_size     = "${var.scaling_config_max_size}"
#       desired_size = "${var.scaling_config_desired_size}"

#       instance_types = ["${var.node_instances_type}"]
#       capacity_type  = "SPOT"

#       iam_role_additional_policies = {
#         "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore" = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
#         "${module.cluster.lb_controller_policy.arn}" = "${module.cluster.lb_controller_policy.arn}"
#       }
      

#       tags = "${merge(var.tags)}"
#     }
#   }

#   ###### Extend node-to-node security group rules ######
#   node_security_group_additional_rules = {
#     ingress_self_all = {
#       description = "Node to node all ports/protocols"
#       protocol    = "-1"
#       from_port   = 0
#       to_port     = 0
#       type        = "ingress"
#       self        = true
#     }
#     ingress_allow_access_from_control_plane = {
#       type                          = "ingress"
#       protocol                      = "tcp"
#       from_port                     = 9443
#       to_port                       = 9443
#       source_cluster_security_group = true
#       description                   = "Allow access from control plane to webhook port of AWS load balancer controller"
#     }
#     egress_all = {
#       description      = "Node all egress"
#       protocol         = "-1"
#       from_port        = 0
#       to_port          = 0
#       type             = "egress"
#       cidr_blocks      = ["0.0.0.0/0"]
#       ipv6_cidr_blocks = ["::/0"]
#     }
#   }


#   ###### Aws-auth configmap ######
#   ###### Create the access in configmap for SSO role to make the cluster accessible ######
#   create_aws_auth_configmap = true
#   manage_aws_auth_configmap = true

#   aws_auth_roles = [
#     {
#       rolearn  = "${module.cluster.eks_administrator_role.arn}"
#       username = "aws_admin_eks"
#       groups   = ["system:masters"]
#     }
#   ]

#   aws_auth_accounts = [
#     "${data.aws_caller_identity.current.account_id}"
#   ]


#   ###### Tags ######
#   tags = merge(var.tags)
#   cluster_tags = {
#     "kubernetes.io/cluster/${var.cluster_name}" = "${var.cluster_name}"
#   }

#   depends_on = [
#     module.network,
#     module.cluster
#     ]
# }

# module "kubernetes" {
#   source = "./modules/eks/kubernetes"

#   namespace     = var.namespace
#   eks_cluster   = module.eks
#   aws_account   = data.aws_caller_identity.current.account_id
#   aws_region    = var.aws_region
#   oidc_provider = module.eks.oidc_provider
#   cluster_name  = var.cluster_name
#   # service_account = "aws-load-balancer-controller"

#   depends_on = [module.eks]
# }

# module "autoscalling_schedule" {
#   source = "./modules/eks/autoscaling_schedule"

#   autoscaling_group_name = module.eks.eks_managed_node_groups_autoscaling_group_names[0]

#   depends_on = [module.kubernetes]
# }