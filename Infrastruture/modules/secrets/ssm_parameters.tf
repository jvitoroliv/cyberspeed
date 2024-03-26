resource "aws_ssm_parameter" "secret_database" {
  name        = var.ssm_secret_database_name
  description = "The root password for mysql database"
  type        = "SecureString"
  value       = "change-me"

  tags = var.tags
}