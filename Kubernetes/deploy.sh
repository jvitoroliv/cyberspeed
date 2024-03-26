#!/bin/bash

#Waranty that will execute kubernets commands in the correct directory
cd kubernetes/

echo "Starting the Kubernetes deployment script..."
echo

# Set the namespace variable
NAMESPACE="applications"

# Check if the namespace exists, create it if not
echo "Checking if namespace '${NAMESPACE}' exists..."
if ! kubectl get namespace "${NAMESPACE}" > /dev/null 2>&1; then
    echo "Namespace does not exist. Creating namespace '${NAMESPACE}'..."
    kubectl create namespace "${NAMESPACE}"
    echo "Namespace '${NAMESPACE}' created."
fi
echo

# Deploy the frontend service
echo "Creating frontend service..."
kubectl apply -f frontend-app-svc.yml -n "${NAMESPACE}" && echo "Frontend service created successfully." || echo "Failed to create frontend service."
echo

# Deploy the frontend application
echo "Deploying frontend application..."
kubectl apply -f frontend-app-deployment.yml -n "${NAMESPACE}" && echo "Frontend application deployed successfully." || echo "Failed to deploy frontend application."
echo

# Deploy the backend application
echo "Deploying backend application..."
kubectl apply -f backend-app-deployment.yml -n "${NAMESPACE}" && echo "Backend application deployed successfully." || echo "Failed to deploy backend application."
echo

# Deploy the pv and pvc of the mysql database
echo "Deploying pv and pvc of the mysql database..."
kubectl apply -f mysql-pv-pvc.yml -n "${NAMESPACE}" && echo "pv and pvc of the mysql database deployed successfully." || echo "Failed to deploy pv and pvc of the mysql database."
echo

# Fetch parameters
echo "Fetching parameters from ssm parameter store..."
rootPassword=$(aws ssm get-parameter --name "/projects/cyberspeed/database/password/master" --with-decryption --query "Parameter.Value" --output text)
database=cyberspeed-db

# Apply the MySQL Helm chart
echo "Applying mysql helm chart..."
helm helm repo add bitnami https://charts.bitnami.com/bitnami
helm install cyberspeed-mysql \
  --set auth.rootPassword=$rootPassword,auth.database=$database \
  --set primary.persistence.existingClaim=mysql-pv-claim \
  bitnami/mysql
echo

echo "Kubernetes deployment script completed."

# Go back to the root directory
cd ..