resource "kubernetes_service_account_v1" "service_account" {
  metadata {
    name      = "cyberspeed-${var.namespace}-sa"
    namespace = var.namespace
  }
  # secret {
  #   name = "${kubernetes_secret.secret.metadata.0.name}"
  # }

  depends_on = [kubernetes_namespace.namespace]
}

# resource "kubernetes_secret" "secret" {
#   metadata {
#     name = "terraform-secret"
#   }
# }

# resource "kubernetes_service_account_v1" "lb_controller" {
#   metadata {
#     name      = "aws-load-balancer-controller"
#     namespace = "kube-system"
#     labels = {
#       "app.kubernetes.io/component" = "controller"
#       "app.kubernetes.io/name"      = "aws-load-balancer-controller"
#     }
#     annotations = {
#       "eks.amazonaws.com/role-arn" = "${aws_iam_role.sa_role.arn}"
#     }
#   }

#   depends_on = [kubernetes_namespace.namespace]
# }