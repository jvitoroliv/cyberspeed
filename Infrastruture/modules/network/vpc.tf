resource "aws_vpc" "vpc" {
  cidr_block = format("%s.0.0/16", var.cidr_block)

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = format("%s-vpc", var.vpc_name)
  }
}