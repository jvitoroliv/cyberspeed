data "kubernetes_secret" "secret" {
  metadata {
    name = kubernetes_service_account_v1.service_account.default_secret_name
  }

  depends_on = [kubernetes_service_account_v1.service_account]
}

output "secret" {
  value = data.kubernetes_secret.secret
}

# output "service_account" {
#   value = kubernetes_service_account_v1.lb_controller
# }