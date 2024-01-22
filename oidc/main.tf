# OIDC for git actions
data "aws_iam_openid_connect_provider" "git" {
  url = var.url  # Replace with the actual URL of your existing provider
}


# Role to be assumed with a federated principal
data "aws_iam_policy_document" "git_aws_oidc" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(data.aws_iam_openid_connect_provider.git.url, "https://", "")}:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringLike"
      variable = "${replace(data.aws_iam_openid_connect_provider.git.url, "https://", "")}:sub"
      values   = ["repo:quadri-olamilekan/*:*"]
    }


    principals {
      identifiers = [data.aws_iam_openid_connect_provider.git.arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "git_action" {
  assume_role_policy = data.aws_iam_policy_document.git_aws_oidc.json
  name               = "eks-iam-roles-repo"
}

resource "aws_iam_policy" "git_action" {
  name = "eks-iam-roles-repo"

  policy = jsonencode({
    Statement = [{
      Action   = ["*"]
      Effect   = "Allow"
      Resource = "*"
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "git_actions_oidc_attachment" {
  role       = aws_iam_role.git_action.name
  policy_arn = aws_iam_policy.git_action.arn
}