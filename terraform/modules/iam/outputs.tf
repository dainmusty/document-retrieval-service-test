output "role_id" {
  description = "ID of the application IAM role"
  value       = aws_iam_role.app.id
}

output "role_name" {
  description = "Name of the application IAM role"
  value       = aws_iam_role.app.name
}

output "role_arn" {
  description = "ARN of the application IAM role"
  value       = aws_iam_role.app.arn
}

output "role_unique_id" {
  description = "Unique ID of the application IAM role"
  value       = aws_iam_role.app.unique_id
}

output "policy_id" {
  description = "ID of the inline application S3 policy"
  value       = aws_iam_role_policy.app_s3.id
}

output "policy_name" {
  description = "Name of the inline application S3 policy"
  value       = aws_iam_role_policy.app_s3.name
}

output "instance_profile_id" {
  description = "ID of the application instance profile"
  value       = aws_iam_instance_profile.app.id
}

output "instance_profile_name" {
  description = "Name of the application instance profile"
  value       = aws_iam_instance_profile.app.name
}

output "instance_profile_arn" {
  description = "ARN of the application instance profile"
  value       = aws_iam_instance_profile.app.arn
}
