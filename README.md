# Terraform Module - IAM Roles for Amazon EKS

## Overview

This Terraform module creates IAM roles necessary for an Amazon EKS (Elastic Kubernetes Service) cluster. It includes two roles: one for the EKS cluster itself (`eks-cluster-demo`) and one for the EKS worker nodes (`eks-node-group-nodes`).

## Usage

```hcl
module "eks_iam_roles" {
  source = "git::https://github.com/BellyBista/IAM-module.git?ref=v1.0.0"

  # Add any required variables here
}
```

## Resources Created

## 1. EKS Cluster Role

- **Name:** `eks-cluster-demo`
- **Assume Role Policy:**

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Sid": "AllowEKSAssumeRole"
    }
  ]
}
```
- **Attached Polcies:**
  - **`AmazonEKSClusterPolicy`**
  - **`AmazonEKSServicePolicy`**

## 2. EKS Node Group Role
- **Name: `eks-node-group-nodes`**
- **Assume Role Policy:**

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Sid": "AllowEKSAssumeRole"
    }
  ]
}
```

- **Attached Polcies:**
  - **`AmazonEC2ContainerRegistryReadOnly`**
  - **`AmazonEC2FullAccess`**
  - **`AmazonEKSWorkerNodePolicy`**
  - **`AmazonEKS_CNI_Policy`**

## Outputs

- **cluster_role:** The ARN of the EKS cluster role(`eks-cluster-demo`)
- **node_role:** The ARN of the EKS node group role (`eks-node-group-nodes)`)

## Notes
- This module is still in progress.

- Please ensure that you have the necessary AWS credentials and permissions before applying this module.

- Feel free to customize the module based on your specific requirements.

- For any issues or questions, contact the module maintainer at olamilekanbello1023@gmail.com  or via phone at +13065021578.

## License

This Terraform module is licensed under the MIT License. 