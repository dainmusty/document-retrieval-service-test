
module "gitactions_tf_role" {

  source = "../modules/gitactions-role"

  role_name            = "gitactions-tf-role"
  create_oidc_provider = false

  github_oidc_subjects = [
    "repo:dainmusty/document-retrieval-service-test.git:*"
  ]

  inline_policy_statements = [



    #########################################
    # S3
    #########################################
    {
      Sid    = "AllowS3PutObject"
      Effect = "Allow"

      Action = [

        "s3:PutObject"

      ]

      Resource = [
        "arn:aws:s3:::blueeagle-prod-app-doc-artifacts",
        "arn:aws:s3:::blueeagle-prod-app-doc-artifacts/*"
      ]
    }

  ]

  tags = {
    Project = "document-retrieval-service-app"
    Owner   = "wandaprep"

  }
}


