# Role and policies for node groups
resource "aws_iam_role" "node_role" {
  name               = var.node_group_name
  assume_role_policy = data.aws_iam_policy_document.nodes.json
}

resource "aws_iam_role_policy_attachment" "nodes-AmazonEKSWorkerNodePolicy" {
  for_each   = toset(local.node_policies)
  policy_arn = each.value
  role       = aws_iam_role.node_role.name
}

# Role and policies for eks cluster
resource "aws_iam_role" "cluster_role" {
  name               = var.cluster_role_name
  assume_role_policy = data.aws_iam_policy_document.eks_assume_role.json
}

resource "aws_iam_role_policy_attachment" "demo-AmazonEKSClusterPolicy" {
  for_each   = toset(local.eks_policies)
  policy_arn = each.value
  role       = aws_iam_role.cluster_role.name

}