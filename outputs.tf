output "node_role" {
  value = aws_iam_role.node_role.arn
}

output "cluster_role" {
  value = aws_iam_role.cluster_role.arn
}