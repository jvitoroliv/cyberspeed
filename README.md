# AWS Terraform EKS Stack Guide

## Overview

This repository contains a foundational model for a Terraform stack that provisions cloud infrastructure on AWS, specifically designed for the creation of an Amazon Elastic Kubernetes Service (EKS) cluster. The stack is equipped with all necessary dependencies for immediate use upon deployment.

## Prerequisites

Before using the code in this repository, you will need to have the following installed:

- Terraform
- AWS CLI
- kubectl
- Git

Ensure that you have configured your AWS CLI with the appropriate credentials and default region to interact with your AWS account.

## Usage Instructions

### Initial Setup

1. **Pre-Stack Creation**: The initial step involves setting up network configurations, roles, and policies which Terraform will utilize to create the EKS cluster and configure Kubernetes.

2. **Cloning the Repository**: Start by cloning this repository to your local machine using:

    ```sh
    git clone [repository-url]
    ```

### Running the Terraform Script

1. **Plannig the EKS Cluster Stack**: Execute the following script to plan the network resources, EKS-related roles and policies, Secrets storage in SSM Parameter Store and the EKS cluster and check if is everything okay with the stack creation:

    ```sh
    ./Infrastructure/scripts/run_check.sh
    ```

2. **Creating the EKS Cluster Stack**: Execute the following script to create the network resources, EKS-related roles and policies, Secrets storage in SSM Parameter Store and deploy the EKS cluster:

    ```sh
    ./Infrastructure/scripts/run.sh
    ```

   Note: that the creation process might take some time.

### Configuring kubectl

After the Terraform stack has been successfully created, set up `kubectl` to interact with your new EKS cluster by running:

```sh
aws eks --region [AWS_REGION] update-kubeconfig --name [EKS_CLUSTER_NAME]

Replace [AWS_REGION] with your AWS region and [EKS_CLUSTER_NAME] with the name of your EKS cluster.

Installing the AWS EBS CSI Driver to be able to create a PVC

  aws iam create-policy \
    --policy-name AmazonEKS_EBS_CSI_Driver_Policy \
    --policy-document file://ebs-csi-driver-policy.json

  aws iam attach-role-policy \
    --role-name eks_t3m_ng-eks-node-group-2024032609531109940000000c \
    --policy-arn arn:aws:iam::851725424717:policy/AmazonEKS_EBS_CSI_Driver_Policy

  eksctl utils associate-iam-oidc-provider --region [AWS_REGION] --cluster [EKS_CLUSTER_NAME] --approve

  eksctl create iamserviceaccount \
    --cluster [EKS_CLUSTER_NAME] \
    --namespace kube-system \
    --name ebs-csi-controller-sa \
    --attach-policy-arn [AmazonEKS_EBS_CSI_Driver_Policy.ARN] \
    --override-existing-serviceaccounts \
    --region [AWS_REGION] \
    --approve

  helm repo add aws-ebs-csi-driver https://kubernetes-sigs.github.io/aws-ebs-csi-driver/

  helm repo update

  helm install aws-ebs-csi-driver aws-ebs-csi-driver/aws-ebs-csi-driver \
    --namespace kube-system \
    --set enableVolumeScheduling=true \
    --set enableVolumeResizing=true \
    --set enableVolumeSnapshot=true \
    --set serviceAccount.controller.create=false \
    --set serviceAccount.controller.name=ebs-csi-controller-sa

  kubectl annotate serviceaccount ebs-csi-controller-sa \
    -n kube-system eks.amazonaws.com/role-arn=arn:aws:iam::851725424717:role/eks_t3m_ng-eks-node-group-2024032609531109940000000c

Deploying Kubernetes Manifests
Deployment: Run the deploy.sh script to apply all the Kubernetes manifests:

kubectl create ns $NAMESPACE

kubectl config set-context --current --namespace=$NAMESPACE

#For MySQL Creation
CD /Kubernetes/Manifests/MySQL

export DB_PASSWORD=$(aws ssm get-parameter --name /projects/cyberspeed/database/password/master --with-decryption --query Parameter.Value --output text)

kubectl create secret generic mysql-secret --from-literal=root-password="${DB_PASSWORD}"

kubectl apply -f mysql-pvc.yaml

kubectl apply -f mysql-deployment.yaml



Now, your EKS cluster should be operational, and you can begin deploying applications to it.

Support

For support and further assistance, please reach out to the repository maintainers or consult the AWS and Terraform documentation.

Make sure to replace `[repository-url]`, `[AWS_REGION]`, and `[EKS_CLUSTER_NAME]` with the actual values that correspond to your setup.



export DB_PASSWORD=$(aws ssm get-parameter --name /projects/cyberspeed/database/password/master --with-decryption --query Parameter.Value --output text)