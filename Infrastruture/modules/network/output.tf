output "vpc" {
  value = aws_vpc.vpc
}

output "private_subnet_1a" {
  value = aws_subnet.private_subnet_1a.id
}

output "private_subnet_1b" {
  value = aws_subnet.private_subnet_1b.id
}

output "private_subnet_1c" {
  value = aws_subnet.private_subnet_1c.id
}

output "public_subnet_1a" {
  value = aws_subnet.public_subnet_1a.id
}

output "public_subnet_1b" {
  value = aws_subnet.public_subnet_1b.id
}

output "public_subnet_1c" {
  value = aws_subnet.public_subnet_1c.id
}