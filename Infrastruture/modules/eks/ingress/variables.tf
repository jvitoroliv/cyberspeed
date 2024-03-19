locals {
  ingress_rule_host = format("%s-%s.%s", var.ingress_api, var.ingress_namespace, var.ingress_domain)
}

variable "ingress_name" {}
variable "ingress_namespace" {}
variable "ingress_annotations" {}
variable "ingress_labels" {}
variable "ingress_service_name" {}
variable "ingress_service_port" {}
variable "ingress_rule_http_path" {}
variable "ingress_rule_http_path_type" {}
variable "ingress_api" {}
variable "ingress_domain" {}
variable "ingress_class_name" {}