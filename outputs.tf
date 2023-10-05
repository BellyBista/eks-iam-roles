output "node_role" {
  value = aws_iam_role.cluster.arn
}

output "cluster_role" {
  value = aws_iam_role.nodes.name
}