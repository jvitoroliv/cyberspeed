###### Network Module ######
output "vpc" {
  value = module.network.vpc.id
}

output "private_subnet_1a" {
  value = module.network.private_subnet_1a.id
}

output "private_subnet_1b" {
  value = module.network.private_subnet_1b.id
}

output "private_subnet_1c" {
  value = module.network.private_subnet_1c.id
}

output "public_subnet_1a" {
  value = module.network.public_subnet_1a.id
}

output "public_subnet_1b" {
  value = module.network.public_subnet_1b.id
}

output "public_subnet_1c" {
  value = module.network.public_subnet_1c.id
}