variable "node_group_name" {
  type        = string
  default     = "eks-node-group-nodes"
  description = "(Optional) The name of the node role policy. If omitted, Terraform will assign a random, unique name."
}

variable "cluster_role_name" {
  type        = string
  default     = "eks-cluster"
  description = "(Optional) The name of the cluster role policy. If omitted, Terraform will assign a random, unique name."
}

variable "pgp_key" {
  type        = string
  description = "PGP key used for encrypting user login profiles"
}


variable "developer" {
  type        = list(string)
  default     = []
  description = "List  developer users"
}

variable "admin" {
  type        = list(string)
  default     = []
  description = "List of  admin users"
}

variable "developer_eks_user_tags" {
  type        = map(string)
  default     = { Department = "developer_eks_user" }
  description = "Tags for developer EKS users"
}

variable "admin_eks_user_tags" {
  type        = map(string)
  default     = { Department = "admin_eks_user" }
  description = "Tags for admin EKS users"
}

variable "eks_developer_group" {
  type        = string
  default     = "developer"
  description = "Name of the EKS developer group"
}

variable "dev_aws_iam_group_membership_name" {
  type        = string
  default     = "dev-group-membership"
  description = "Name of the developer AWS IAM group membership"
}

variable "admin_aws_iam_group_membership_name" {
  type        = string
  default     = "masters-group-membership"
  description = "Name of the admin AWS IAM group membership"
}

variable "eks_masters_group" {
  type        = string
  default     = "masters"
  description = "Name of the EKS masters group"
}

variable "developer_actions" {
  type = list(string)
  default = [
    "eks:DescribeNodegroup",
    "eks:ListNodegroups",
    "eks:DescribeCluster",
    "eks:ListClusters",
    "eks:AccessKubernetesApi",
    "ssm:GetParameter",
    "eks:ListUpdates",
    "eks:ListFargateProfiles",
  ]
  description = "Actions permitted for developers"
}
