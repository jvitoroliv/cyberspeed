resource "kubernetes_namespace" "namespace" {
  metadata {
    annotations = {
      name = var.namespace
    }
    name = var.namespace
  }

  depends_on = [var.eks_cluster, time_sleep.wait_some_time]
}
resource "null_resource" "previous" {}
resource "time_sleep" "wait_some_time" {
  depends_on = [null_resource.previous]

  create_duration = "120s"
}