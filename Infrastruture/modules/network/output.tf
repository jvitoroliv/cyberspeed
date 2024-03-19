output "vpc" {
  value = aws_vpc.vpc
}

output "private_subnet_1a" {
  value = aws_subnet.private_subnet_1a
}

output "private_subnet_1b" {
  value = aws_subnet.private_subnet_1b
}

output "private_subnet_1c" {
  value = aws_subnet.private_subnet_1c
}

output "public_subnet_1a" {
  value = aws_subnet.public_subnet_1a
}

output "public_subnet_1b" {
  value = aws_subnet.public_subnet_1b
}

output "public_subnet_1c" {
  value = aws_subnet.public_subnet_1c
}