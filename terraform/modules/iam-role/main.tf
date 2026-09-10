data "aws_caller_identity" "current" {}

##############################
# GitHub OIDC provider
##############################

resource "aws_iam_openid_connect_provider" "github" {
  count = var.trust_type == "github_oidc" && var.create_oidc_provider ? 1 : 0

  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com"
  ]

  thumbprint_list = [
    "6938fd4d98bab03faadb97b34396831e3780aea1"
  ]

  tags = var.tags
}

##############################
# GitHub OIDC provider ARN
##############################

locals {
  github_oidc_provider_arn = var.create_oidc_provider ? aws_iam_openid_connect_provider.github[0].arn : "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/token.actions.githubusercontent.com"
}

##############################
# Trust policies
##############################

locals {
  github_oidc_assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Federated = local.github_oidc_provider_arn
        }

        Action = "sts:AssumeRoleWithWebIdentity"

        Condition = {
          StringEquals = {
            "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
          }

          StringLike = {
            "token.actions.githubusercontent.com:sub" = var.github_oidc_subjects
          }
        }
      }
    ]
  })

  ec2_assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "ec2.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })

  assume_role_policy = var.trust_type == "github_oidc" ? local.github_oidc_assume_role_policy : local.ec2_assume_role_policy
}

##############################
# IAM role
##############################

resource "aws_iam_role" "bootstrap_role" {
  name = var.role_name

  assume_role_policy = local.assume_role_policy

  tags = var.tags
}


##############################
# Inline policy
##############################

resource "aws_iam_policy" "inline" {
  name = "${var.role_name}-policy"

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      for st in var.inline_policy_statements : {
        Sid      = st.Sid
        Effect   = st.Effect
        Action   = st.Action
        Resource = st.Resource
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_inline" {
  role       = aws_iam_role.bootstrap_role.name
  policy_arn = aws_iam_policy.inline.arn
}

##############################
# Managed policy attachments
##############################

resource "aws_iam_role_policy_attachment" "managed" {
  for_each = toset(var.managed_policy_arns)

  role       = aws_iam_role.bootstrap_role.name
  policy_arn = each.key
}