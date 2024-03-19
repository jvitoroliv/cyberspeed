#!/bin/bash

echo "Starting the Kubernetes deployment script..."
echo

# Set the namespace variable
NAMESPACE="applications"

# Set the Postgres environment variables
export POSTGRES_DB=postgresdb
export POSTGRES_USER=admin
# Ensure to replace 'mypass' with your actual desired password.
export POSTGRES_PASSWORD=mypass

# Check if the namespace exists, create it if not
echo "Checking if namespace '${NAMESPACE}' exists..."
if ! kubectl get namespace "${NAMESPACE}" > /dev/null 2>&1; then
    echo "Namespace does not exist. Creating namespace '${NAMESPACE}'..."
    kubectl create namespace "${NAMESPACE}"
    echo "Namespace '${NAMESPACE}' created."
fi
echo

# Apply the MySQL Helm chart
echo "Applying mysql helm chart..."
helm repo add choerodon https://openchart.choerodon.com.cn/choerodon/c7n
helm install cyberspeed-mysql choerodon/mysql --version 8.5.1
echo

# Deploy the backend application
echo "Deploying backend application..."
kubectl apply -f backend-app-deployment.yml -n "${NAMESPACE}" && echo "Backend application deployed successfully." || echo "Failed to deploy backend application."
echo

# Deploy the frontend application
echo "Deploying frontend application..."
kubectl apply -f frontend-app-deployment.yml -n "${NAMESPACE}" && echo "Frontend application deployed successfully." || echo "Failed to deploy frontend application."
echo

# Deploy the frontend service
echo "Creating frontend service..."
kubectl apply -f frontend-app-svc.yml -n "${NAMESPACE}" && echo "Frontend service created successfully." || echo "Failed to create frontend service."
echo

echo "Kubernetes deployment script completed."
