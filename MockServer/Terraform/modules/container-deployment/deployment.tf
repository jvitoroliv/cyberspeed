# resource "kubernetes_deployment" "mockserver_deployment" {
#   metadata {
#     name      = "mockserver-deployment"
#     namespace = kubernetes_namespace.mockserver_ns.metadata[0].name
#   }

#   spec {
#     replicas = 1

#     selector {
#       match_labels = {
#         app = "mockserver"
#       }
#     }

#     template {
#       metadata {
#         labels = {
#           app = "mockserver"
#         }
#       }

#       spec {
#         container {
#           name  = "mockserver"
#           image = var.docker_image

#           port {
#             container_port = 3000
#           }
#         }
#       }
#     }
#   }
# }
