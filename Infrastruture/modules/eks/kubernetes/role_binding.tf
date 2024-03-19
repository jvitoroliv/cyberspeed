resource "kubernetes_role_binding" "role_binding" {
  metadata {
    name      = "everything-in-${var.namespace}"
    namespace = var.namespace
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = "all-in-${var.namespace}-namespace"
  }
  subject {
    kind      = "Group"
    name      = "'[use your own group]'"
    api_group = "rbac.authorization.k8s.io"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "default"
    namespace = "kube-system"
  }
  subject {
    kind      = "Group"
    name      = "system:masters"
    api_group = "rbac.authorization.k8s.io"
  }

  depends_on = [kubernetes_namespace.namespace]
}