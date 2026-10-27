#!/bin/bash

# Ensure terraform commands execute in the correct directory
cd Infrastructure/

# Run Terraform to validate the stack
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
