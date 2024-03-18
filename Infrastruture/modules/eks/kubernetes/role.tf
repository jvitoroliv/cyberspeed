resource "kubernetes_role" "role" {
  metadata {
    name      = "all-in-${var.namespace}-namespace"
    namespace = var.namespace
  }

  rule {
    api_groups = ["", "extensions", "apps"]
    resources  = ["'*'"]
    verbs      = ["'*'"]
  }

  depends_on = [kubernetes_namespace.namespace]
}