output "node_role" {
  value       = module.eks-iam-roles.node_role
  description = "The ARN of the EKS node role"
}

output "cluster_role" {
  value       = module.eks-iam-roles.cluster_role
  description = "The ARN of the EKS cluster role"
}

output "developer_password" {
  value       = module.eks-iam-roles.developer_password
  description = "Provided passwords for users in the developers group"
}

output "admin_password" {
  value       = module.eks-iam-roles.admin_password
  description = "Provided passwords for users in the masters group"
}