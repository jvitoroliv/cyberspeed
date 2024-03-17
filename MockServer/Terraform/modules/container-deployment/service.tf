# resource "kubernetes_service" "mockserver_service" {
#   metadata {
#     name      = "mockserver-service"
#     namespace = kubernetes_namespace.mockserver_ns.metadata[0].name
#     annotations = {
#       "service.beta.kubernetes.io/aws-load-balancer-type" = "nlb"
#     }
#   }

#   spec {
#     selector = {
#       app = "mockserver"
#     }

#     port {
#       protocol    = "TCP"
#       port        = 3000
#       target_port = 3000
#     }

#     type = "LoadBalancer"
#   }
# }
