locals {
  eks_policies = [
    "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
    "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  ]
  node_policies = [
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
    "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
  ]
}

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

# Developer User Login Profiles
resource "aws_iam_user_login_profile" "Developer_user" {
  for_each                = aws_iam_user.developer_eks_user
  user                    = aws_iam_user.developer_eks_user[each.key].name
  password_reset_required = true
  pgp_key                 = var.pgp_key
}

# Admin User Login Profiles
resource "aws_iam_user_login_profile" "Admin_user" {
  for_each                = aws_iam_user.admin_eks_user
  user                    = aws_iam_user.admin_eks_user[each.key].name
  password_reset_required = true
  pgp_key                 = var.pgp_key
}

# Developer Users
resource "aws_iam_user" "developer_eks_user" {
  for_each      = toset(var.developer)
  name          = each.key
  force_destroy = true
  tags          = var.developer_eks_user_tags
}

# Admin Users
resource "aws_iam_user" "admin_eks_user" {
  for_each      = toset(var.admin)
  name          = each.key
  force_destroy = true
  tags          = var.admin_eks_user_tags
}

# EKS Developer Group
resource "aws_iam_group" "eks_developer" {
  name = var.eks_developer_group
}

resource "aws_iam_group_policy" "developer_policy" {
  name   = var.eks_developer_group
  group  = aws_iam_group.eks_developer.name
  policy = data.aws_iam_policy_document.developer.json
}

resource "aws_iam_group_membership" "db_team" {
  name  = var.dev_aws_iam_group_membership_name
  users = [for user in aws_iam_user.developer_eks_user : user.name]
  group = aws_iam_group.eks_developer.name
}

# EKS Admin Group
resource "aws_iam_group" "eks_masters" {
  name = var.eks_masters_group
}

resource "aws_iam_group_policy" "masters_policy" {
  name   = var.eks_masters_group
  group  = aws_iam_group.eks_masters.name
  policy = data.aws_iam_policy_document.admin_role.json
}

resource "aws_iam_group_membership" "masters_team" {
  name  = var.admin_aws_iam_group_membership_name
  users = [for user in aws_iam_user.admin_eks_user : user.name]
  group = aws_iam_group.eks_masters.name
}

resource "aws_iam_role" "masters" {
  name               = "admin-eks-Role"
  assume_role_policy = data.aws_iam_policy_document.admin_assume_role.json
}

resource "aws_iam_role_policy_attachment" "admin_policy" {
  role       = aws_iam_role.masters.name
  policy_arn = aws_iam_policy.eks_admin.arn
}

resource "aws_iam_policy" "eks_admin" {
  name   = "eks-admin"
  policy = data.aws_iam_policy_document.admin.json
}

# Password
resource "aws_iam_account_password_policy" "strict" {
  minimum_password_length        = 8
  require_lowercase_characters   = true
  require_numbers                = true
  require_uppercase_characters   = true
  require_symbols                = true
  allow_users_to_change_password = true
}