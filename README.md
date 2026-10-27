# EKS Infrastructure Stack — DevSecOps Assessment

> **Technical Assessment:** This repository contains my solution to a DevSecOps coding assessment. The challenge required designing and implementing a scalable, containerized web application stack using Infrastructure as Code, Kubernetes orchestration, secrets management, and CI/CD pipeline considerations — delivered within a 4-day timeframe.

## Architecture Overview

The solution provisions a production-grade Amazon EKS cluster on AWS using Terraform, with a modular infrastructure design:

```
├── Infrastructure/
│   ├── main.tf              # Root module — orchestrates all child modules
│   ├── providers.tf         # AWS, Kubernetes, and Helm provider configuration
│   ├── variables.tf         # Input variables with sensible defaults
│   ├── versions.tf          # Provider version constraints and S3 backend
│   ├── outputs.tf           # Exported values from all modules
│   ├── modules/
│   │   ├── network/         # VPC, subnets (3 public + 3 private), NAT, IGW, routing
│   │   ├── iam/             # EKS cluster role, ALB controller policy, admin access
│   │   ├── eks/             # EKS cluster with managed node groups (terraform-aws-modules/eks v20.8.3)
│   │   └── secrets/         # SSM Parameter Store for database credentials
│   └── scripts/
│       ├── run.sh           # Full init + plan + apply
│       └── run_check.sh     # Dry-run validation (init + plan only)
├── Kubernetes/
│   └── Manifests/
│       ├── Wordpress/       # WordPress pod, service, and Helm chart metadata
│       ├── Database/        # MySQL 5.7 pod
│       └── EBS_CSI/         # EBS CSI driver IAM policy for persistent volumes
└── .github/
    └── workflows/
        └── main.yml         # CI/CD pipeline — validate on PR, plan on merge
```

## Tech Stack

| Component | Technology |
|---|---|
| Infrastructure as Code | Terraform >= 0.13.1 |
| Cloud Provider | AWS (us-east-1) |
| Container Orchestration | Amazon EKS 1.29 |
| EKS Module | terraform-aws-modules/eks/aws v20.8.3 |
| Node Groups | Managed — t3.large (ON_DEMAND), min 1 / max 5 / desired 3 |
| Networking | Custom VPC with 3 AZs, public + private subnets, NAT Gateway |
| Secrets Management | AWS SSM Parameter Store |
| Load Balancing | AWS ALB (IAM policy for controller included) |
| CI/CD | GitHub Actions (Terraform validate + plan) |
| Web Application | WordPress 6.4 (containerized) |
| Database | MySQL 5.7 (containerized) |
| Storage | EBS CSI Driver for Kubernetes PersistentVolumes |

## Prerequisites

- [Terraform](https://www.terraform.io/downloads) >= 0.13.1
- [AWS CLI](https://aws.amazon.com/cli/) configured with appropriate credentials
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- [Helm](https://helm.sh/docs/intro/install/) (for EBS CSI driver installation)
- Git

## Usage

### 1. Configure the Backend

Update `Infrastructure/versions.tf` with your S3 bucket for remote state:

```hcl
backend "s3" {
  bucket = "<YOUR_S3_BUCKET>"
  key    = "cyberspeed/project-v2/tfstate"
  region = "us-east-1"
}
```

### 2. Validate the Stack (Dry Run)

```sh
./Infrastructure/scripts/run_check.sh
```

### 3. Deploy the Infrastructure

```sh
./Infrastructure/scripts/run.sh
```

> Note: EKS cluster creation takes approximately 10-15 minutes.

### 4. Configure kubectl

```sh
aws eks --region <AWS_REGION> update-kubeconfig --name <EKS_CLUSTER_NAME>
```

### 5. Install the EBS CSI Driver

```sh
# Create the IAM policy
aws iam create-policy \
  --policy-name AmazonEKS_EBS_CSI_Driver_Policy \
  --policy-document file://Kubernetes/Manifests/EBS_CSI/ebs-csi-driver-policy.json

# Attach the policy to the node group role
aws iam attach-role-policy \
  --role-name <NODE_GROUP_ROLE_NAME> \
  --policy-arn arn:aws:iam::<AWS_ACCOUNT_ID>:policy/AmazonEKS_EBS_CSI_Driver_Policy

# Associate OIDC provider
eksctl utils associate-iam-oidc-provider \
  --region <AWS_REGION> --cluster <EKS_CLUSTER_NAME> --approve

# Create IAM service account for the CSI controller
eksctl create iamserviceaccount \
  --cluster <EKS_CLUSTER_NAME> \
  --namespace kube-system \
  --name ebs-csi-controller-sa \
  --attach-policy-arn <EBS_CSI_DRIVER_POLICY_ARN> \
  --override-existing-serviceaccounts \
  --region <AWS_REGION> \
  --approve

# Install the EBS CSI driver via Helm
helm repo add aws-ebs-csi-driver https://kubernetes-sigs.github.io/aws-ebs-csi-driver/
helm repo update
helm install aws-ebs-csi-driver aws-ebs-csi-driver/aws-ebs-csi-driver \
  --namespace kube-system \
  --set enableVolumeScheduling=true \
  --set enableVolumeResizing=true \
  --set enableVolumeSnapshot=true \
  --set serviceAccount.controller.create=false \
  --set serviceAccount.controller.name=ebs-csi-controller-sa
```

### 6. Deploy the Application

```sh
# Create namespace
kubectl create ns cyberspeed

# Set namespace context
kubectl config set-context --current --namespace=cyberspeed

# Create database secret from SSM Parameter Store
export DB_PASSWORD=$(aws ssm get-parameter \
  --name /projects/cyberspeed/database/password/master \
  --with-decryption --query Parameter.Value --output text)
kubectl create secret generic mysql-secret --from-literal=root-password="${DB_PASSWORD}"

# Deploy MySQL
kubectl apply -f Kubernetes/Manifests/Database/mysql.yml

# Deploy WordPress
kubectl apply -f Kubernetes/Manifests/Wordpress/wordpress.yml
kubectl apply -f Kubernetes/Manifests/Wordpress/service.yml
```

## Architecture Decisions

- **Modular Terraform structure:** Each infrastructure concern (networking, IAM, EKS, secrets) is isolated in its own module with well-defined inputs and outputs. This supports independent testing, reusability, and clear separation of concerns.

- **3-AZ deployment:** Both public and private subnets span three availability zones, providing high availability for the EKS control plane and worker nodes.

- **Private worker nodes:** Worker nodes are deployed in private subnets with internet access via NAT Gateway, following AWS security best practices for EKS.

- **SSM Parameter Store for secrets:** Database credentials are stored in AWS SSM Parameter Store rather than hardcoded, with SecureString encryption at rest. Kubernetes secrets are created at deployment time from SSM values.

- **EBS CSI Driver:** Included to support persistent storage for stateful workloads (MySQL), ensuring data durability across pod restarts.

- **CI/CD scaffold:** GitHub Actions workflow validates Terraform formatting and configuration on PRs, with a plan step for infrastructure change review before merge.

## Assessment Requirements Covered

| Requirement | Implementation |
|---|---|
| Version control | Git with GitHub |
| Container orchestration | Amazon EKS with managed node groups |
| Cloud infrastructure provisioning | Terraform with modular AWS resources |
| Scalability | EKS auto-scaling (min 1 / max 5 nodes) |
| Security (DevSecOps) | Private subnets, IAM least-privilege, SSM secrets, no hardcoded credentials |
| Containerization best practices | Public container images, resource limits, health configuration |
| Networking | Custom VPC, public/private subnet separation, NAT Gateway, ALB controller |
| IaC principles | Terraform modules, remote state, variable-driven configuration |
| Secrets management | AWS SSM Parameter Store with SecureString |
| CI/CD (bonus) | GitHub Actions workflow for validation and planning |
