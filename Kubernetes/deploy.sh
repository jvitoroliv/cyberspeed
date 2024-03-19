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

# Apply the Postgres ConfigMap
echo "Applying Postgres ConfigMap..."
envsubst < postgres-configmap.yml | kubectl apply -f - -n "${NAMESPACE}" && echo "Postgres ConfigMap applied successfully." || echo "Failed to apply Postgres ConfigMap."
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

# Deploy the Postgres deployment
echo "Deploying Postgres..."
kubectl apply -f postgres-deployment.yml -n "${NAMESPACE}" && echo "Postgres deployed successfully." || echo "Failed to deploy Postgres."
echo

# Apply the Postgres PVC
echo "Applying Postgres PVC..."
kubectl apply -f postgres-pvc-pv.yml -n "${NAMESPACE}" && echo "Postgres PVC applied successfully." || echo "Failed to apply Postgres PVC."
echo

# Create the Postgres service
echo "Creating Postgres service..."
kubectl apply -f postgres-svc.yml -n "${NAMESPACE}" && echo "Postgres service created successfully." || echo "Failed to create Postgres service."
echo

echo "Kubernetes deployment script completed."
