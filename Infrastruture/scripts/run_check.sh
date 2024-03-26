#!/bin/bash

#Waranty that will execute terraform commands in the correct directory
cd Infrastruture/

# Run Terraform to create the complete stack
echo "Starting running initial_stack..."
echo
echo "Initializing Terraform..."
terraform init
echo

echo "Executing terraform plan..."
terraform plan
echo

# Go back to the root directory
cd ..