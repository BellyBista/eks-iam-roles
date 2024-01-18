# Terraform Module - IAM Roles for Amazon EKS

## Overview

This Terraform module configures AWS Identity and Access Management (IAM) resources for managing user access and permissions within your AWS environment. The script creates IAM users, groups, policies, and roles tailored for EKS (Elastic Kubernetes Service) administration.

## Security & Compliance [<img src="https://cloudposse.com/wp-content/uploads/2020/11/bridgecrew.svg" width="250" align="right" />](https://bridgecrew.io/)

Security scanning is graciously provided by Bridgecrew. Bridgecrew is the leading fully hosted, cloud-native solution providing continuous Terraform security and compliance.

| Benchmark | Description |
|--------|---------------|
| [![Infrastructure Security](https://www.bridgecrew.cloud/badges/github/quadri-olamilekan/terraform-aws-eks-iam-roles/general)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=quadri-olamilekan%2Fterraform-aws-eks-iam-roles&benchmark=INFRASTRUCTURE+SECURITY) | Infrastructure Security Compliance |
| [![CIS KUBERNETES](https://www.bridgecrew.cloud/badges/github/quadri-olamilekan/terraform-aws-eks-iam-roles/cis_kubernetes_16)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=quadri-olamilekan%2Fterraform-aws-eks-iam-roles&benchmark=CIS+KUBERNETES+V1.6) | Center for Internet Security, KUBERNETES Compliance |
| [![CIS AWS](https://www.bridgecrew.cloud/badges/github/quadri-olamilekan/terraform-aws-eks-iam-roles/cis_aws)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=quadri-olamilekan%2Fterraform-aws-eks-iam-roles&benchmark=CIS+AWS+V1.2) | Center for Internet Security, AWS Compliance |
| [![CIS AZURE](https://www.bridgecrew.cloud/badges/github/quadri-olamilekan/terraform-aws-eks-iam-roles/cis_azure)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=quadri-olamilekan%2Fterraform-aws-eks-iam-roles&benchmark=CIS+AZURE+V1.1) | Center for Internet Security, AZURE Compliance |
| [![PCI-DSS](https://www.bridgecrew.cloud/badges/github/quadri-olamilekan/terraform-aws-eks-iam-roles/pci)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=quadri-olamilekan%2Fterraform-aws-eks-iam-roles&benchmark=PCI-DSS+V3.2) | Payment Card Industry Data Security Standards Compliance |
| [![NIST-800-53](https://www.bridgecrew.cloud/badges/github/quadri-olamilekan/terraform-aws-eks-iam-roles/nist)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=quadri-olamilekan%2Fterraform-aws-eks-iam-roles&benchmark=NIST-800-53) | National Institute of Standards and Technology Compliance |
| [![ISO27001](https://www.bridgecrew.cloud/badges/github/quadri-olamilekan/terraform-aws-eks-iam-roles/iso)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=quadri-olamilekan%2Fterraform-aws-eks-iam-roles&benchmark=ISO27001) | Information Security Management System, ISO/IEC 27001 Compliance |
| [![SOC2](https://www.bridgecrew.cloud/badges/github/quadri-olamilekan/terraform-aws-eks-iam-roles/soc2)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=quadri-olamilekan%2Fterraform-aws-eks-iam-roles&benchmark=SOC2)| Service Organization Control 2 Compliance |
| [![CIS GCP](https://www.bridgecrew.cloud/badges/github/quadri-olamilekan/terraform-aws-eks-iam-roles/cis_gcp)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=quadri-olamilekan%2Fterraform-aws-eks-iam-roles&benchmark=CIS+GCP+V1.1) | Center for Internet Security, GCP Compliance |
| [![HIPAA](https://www.bridgecrew.cloud/badges/github/quadri-olamilekan/terraform-aws-eks-iam-roles/hipaa)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=quadri-olamilekan%2Fterraform-aws-eks-iam-roles&benchmark=HIPAA) | Health Insurance Portability and Accountability Compliance |
| [![CIS EKS](https://www.bridgecrew.cloud/badges/github/quadri-olamilekan/terraform-aws-eks-iam-roles/cis_eks_11)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=quadri-olamilekan%2Fterraform-aws-eks-iam-roles&benchmark=CIS+EKS+V1.1) | Center for Internet Security, EKS Compliance |
| [![CIS DOCKER](https://www.bridgecrew.cloud/badges/github/quadri-olamilekan/terraform-aws-eks-iam-roles/cis_docker_12)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=quadri-olamilekan%2Fterraform-aws-eks-iam-roles&benchmark=CIS+DOCKER+V1.2) | Center for Internet Security, DOCKER Compliance |
| [![CIS GKE](https://www.bridgecrew.cloud/badges/github/quadri-olamilekan/terraform-aws-eks-iam-roles/cis_gke_11)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=quadri-olamilekan%2Fterraform-aws-eks-iam-roles&benchmark=CIS+GKE+V1.1) | Center for Internet Security, GKE Compliance |
| [![FEDRAMP (MODERATE)](https://www.bridgecrew.cloud/badges/github/quadri-olamilekan/terraform-aws-eks-iam-roles/fedramp_moderate)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=quadri-olamilekan%2Fterraform-aws-eks-iam-roles&benchmark=FEDRAMP+%28MODERATE%29) | Federal Risk and Authorization Management Program|

## Usage

```hcl
module "eks-iam-roles" {
  source  = "quadri-olamilekan/eks-iam-roles/aws"
  version = "1.0.4"
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
