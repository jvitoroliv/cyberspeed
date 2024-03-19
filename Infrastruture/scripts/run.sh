#!/bin/bash

# Run Terraform to create the complete stack
echo "Starting running initial_stack..."
echo
echo "Initializing Terraform..."
terraform init
echo

echo "Executing terraform plan..."
terraform plan
echo

echo "Applying changes with terraform apply..."
terraform apply
echo