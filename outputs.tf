output "node_role" {
  value = aws_iam_role.nodes.arn
}

output "cluster_role" {
  value = aws_iam_role.demo.name
}