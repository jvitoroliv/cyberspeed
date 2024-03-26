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

3. **Variables Review**: It is essential to review the variables defined in the variables file. Ensure they align with your infrastructure requirements. Adjust the configurations in the `locals` block which is reserved for `aws_auth` configuration post stack deployment.

   - **Adjustments**: Some changes are mandatory, such as resource names, while others are optional, like the number of nodes, and the scaling parameters (maximum, minimum, and desired configurations).

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

Deploying Kubernetes Manifests
Deployment: Run the deploy.sh script to apply all the Kubernetes manifests:

./Kubernetes/deploy.sh

Now, your EKS cluster should be operational, and you can begin deploying applications to it.

Support

For support and further assistance, please reach out to the repository maintainers or consult the AWS and Terraform documentation.

Make sure to replace `[repository-url]`, `[AWS_REGION]`, and `[EKS_CLUSTER_NAME]` with the actual values that correspond to your setup.



