resource "aws_iam_role" "app" {
  name = "blueeagle-prod-app-role"

  assume_role_policy = jsonencode({
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

  tags = {
    Project     = "BlueEagle"
    Environment = "prod"
    Tier        = "app"
    ManagedBy   = "Terraform"
  }
}


resource "aws_iam_role_policy" "app_s3" {
  name = var.policy_name
  role = aws_iam_role.app.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Sid    = "CustomStatement"
        Effect = "Allow"

        Action   = var.policy_actions
        Resource = var.policy_resources
      }
    ]
  })
}


# Instance profile for the IAM role
resource "aws_iam_instance_profile" "app" {
  name = "blueeagle-prod-app-profile"
  role = aws_iam_role.app.name

  tags = {
    Project     = "BlueEagle"
    Environment = "prod"
    Tier        = "app"
    ManagedBy   = "Terraform"
  }
}