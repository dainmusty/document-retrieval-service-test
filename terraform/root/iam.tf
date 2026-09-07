# # IAM Module
module "iam" {
  source = "../modules/iam"

  policy_actions = [
    "s3:GetObject",
    "s3:PutObject"
  ]
  policy_resources = [
    "arn:aws:s3:::mustydain/*",
  ]
  policy_name = "blueeagle-prod-app-s3-policy"
}

