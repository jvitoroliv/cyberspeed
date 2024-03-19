#!/bin/bash

echo "Starting running initial_stack..."
echo

# Preparing files to isolate the desired Terraform configuration
echo "Preparing files..."
mkdir temp
mv main2.tf temp/
echo "Files prepared."
echo

# Executing Terraform commands on the isolated configuration
echo "Initializing Terraform..."
terraform init
echo

echo "Executing terraform plan..."
terraform plan
echo

echo "Applying changes with terraform apply..."
terraform apply
echo

# Restoring files to their original state
echo "Restoring files..."
mv temp/* .
rmdir temp
echo