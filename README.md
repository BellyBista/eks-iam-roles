# Terraform Module - IAM Roles for Amazon EKS

## Overview

This Terraform module configures AWS Identity and Access Management (IAM) resources for managing user access and permissions within your AWS environment. The script creates IAM users, groups, policies, and roles tailored for EKS (Elastic Kubernetes Service) administration.

## Usage

```hcl
module "eks-iam-roles" {
  source  = "quadri-olamilekan/eks-iam-roles/aws"
  version = "1.0.1"
  # insert the 1 required variable here
}
```

## Resources Created

## 1. EKS Cluster Role

- **Name:** `eks-cluster`
- **Assume Role Policy:**

```json
{
  "Statement": [
    {
      "Sid": "AllowEKSAssumeRole",
      "Effect": "Allow",
      "Action": ["sts:AssumeRole"],
      "Principal": {
        "Service": "eks.amazonaws.com"
      }
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
  "Statement": [
    {
      "Sid": "AllowEKSAssumeRole",
      "Effect": "Allow",
      "Action": ["sts:AssumeRole"],
      "Principal": {
        "Service": "ec2.amazonaws.com"
      }
    }
  ]
}
```

- **Attached Polcies:**
  - **`AmazonEC2ContainerRegistryReadOnly`**
  - **`AmazonEC2FullAccess`**
  - **`AmazonEKSWorkerNodePolicy`**
  - **`AmazonEKS_CNI_Policy`**

## 3. IAM Password Policy
- Created an IAM password policy enforcing strict password requirements for security.

## 4. IAM Groups
- **EKS Developer Group:**
  - Created an IAM group named "developer" for EKS developers that doesn't require administrator access.
- **EKS Masters Group:**
  - Created an IAM group named "masters" for EKS administrators.

## 5. IAM Group Memberships
- Established group memberships for users in the "developer" and "masters" groups.

## 6. IAM Group Policies
- **Developer Group Policy:**
  -   Created an IAM policy for the "developer" group, allowing specific EKS acttions.
- **Masters Group Policy**
  - Created an IAM policy for the "masters" group, allowing the assumption of the admin role.

## 7. IAM Roles and Policies
- Created a broad IAM policy and IAM role  allowing various actions.


## Outputs

- **cluster_role:** The ARN of the EKS cluster role(`eks-cluster`)
- **node_role:** The ARN of the EKS node group role (`eks-node-group-nodes)`)
- Encrypted passwords for users in the "developer" and "masters" groups.

## Notes

- Please ensure that you have the necessary AWS credentials and permissions before applying this module.

- Feel free to customize the module based on your specific requirements.

- For any issues or questions, contact the module maintainer at olamilekanbello1023@gmail.com  or via phone at +13065021578.

## License

This Terraform module is licensed under the MIT License. 
