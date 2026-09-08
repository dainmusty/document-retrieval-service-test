output "role_name" {
  value = aws_iam_role.github_actions.name
}

output "role_arn" {
  value = aws_iam_role.github_actions.arn
}

output "inline_policy_arns" {
  value = aws_iam_policy.inline.arn
  }


