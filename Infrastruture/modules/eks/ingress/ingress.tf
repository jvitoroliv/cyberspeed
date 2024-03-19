resource "kubernetes_ingress_v1" "k8s_ingress" {
  metadata {
    name        = var.ingress_name
    namespace   = var.ingress_namespace
    annotations = var.ingress_annotations
    labels = {
      (var.ingress_labels) = var.ingress_name
    }
  }

  spec {
    ingress_class_name = var.ingress_class_name
    rule {
      host = local.ingress_rule_host
      http {
        path {
          backend {
            service {
              name = var.ingress_service_name
              port {
                number = var.ingress_service_port
              }
            }
          }
          path      = var.ingress_rule_http_path
          path_type = var.ingress_rule_http_path_type
        }
      }
    }
  }
}