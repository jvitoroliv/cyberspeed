# resource "aws_vpc" "vpc" {
#   cidr_block = var.cidr_block != "" ? var.cidr_block : null

#   tags = {
#     Name = "my-vpc"
#   }
# }

# resource "aws_subnet" "subnet" {
#   count = 3

#   vpc_id     = aws_vpc.vpc.id
#   cidr_block = cidrsubnet(var.cidr_block, 8, count.index)
# }

# # Add other VPC resources like Internet Gateway, Route Tables, etc.
