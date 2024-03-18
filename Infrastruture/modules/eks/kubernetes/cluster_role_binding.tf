resource "kubernetes_cluster_role_binding" "cluster_Role_Binding" {
  metadata {
    name = "cyberspeed-${var.namespace}-rolebinding"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "cyberspeed-${var.namespace}-sa"
    namespace = var.namespace
  }
  subject {
    kind      = "ServiceAccount"
    name      = "default"
    namespace = "kube-system"
  }
  subject {
    kind = "Group"
    name = "system:masters"
  }

  depends_on = [kubernetes_namespace.namespace]
}