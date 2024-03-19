resource "helm_release" "lb_controller" {
  name      = "nginx-ingress-controller"
  namespace = "kube-system"

  repository = "https://helm.nginx.com/stable"
  chart      = "nginx-ingress"


  # set {
  #   name  = "clusterName"
  #   value = var.cluster_name
  # }

  # set {
  #   name  = "serviceAccount.create"
  #   value = false
  # }

  # set {
  #   name  = "serviceAccount.name"
  #   value = var.service_account
  # }

  # set {
  #   name  = "vpcId"
  #   value = var.vpc_id
  # }

  # set {
  #   name  = "region"
  #   value = var.aws_region
  # }
}