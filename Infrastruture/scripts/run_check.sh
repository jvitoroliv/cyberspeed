#!/bin/bash

#Waranty that will execute terraform commands in the correct directory
cd Infrastruture/

# Run Terraform to create the complete stack
echo "Starting running initial_stack..."
echo
echo "Initializing Terraform..."
terraform init | tee init-output.txt
echo

echo "Executing terraform plan..."
terraform plan | tee plan-output.txt
echo

# Go back to the root directory
cd ..