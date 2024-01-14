output "node_role" {
  value       = aws_iam_role.node_role.arn
  description = "The ARN of the EKS node role"
}

output "cluster_role" {
  value       = aws_iam_role.cluster_role.arn
  description = "The ARN of the EKS cluster role"
}

output "developer_password" {
  value = {
    for user, profile in aws_iam_user_login_profile.Developer_user :
    user => {
      username = user
      password = profile.encrypted_password
      # password | base64 --decode | keybase pgp decrypt
    }
  }
  description = "Provided passwords for users in the developers group"
}

output "admin_password" {
  value = {
    for user, profile in aws_iam_user_login_profile.Admin_user :
    user => {
      username = user
      password = profile.encrypted_password
      # password | base64 --decode | keybase pgp decrypt
    }
  }
  description = "Provided passwords for users in the masters group"
}