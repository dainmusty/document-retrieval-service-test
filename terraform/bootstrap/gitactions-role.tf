
module "gitactions_tf_role" {

  source = "../modules/gitactions-role"

  role_name            = "gitactions-tf-role"
  create_oidc_provider = false

  github_oidc_subjects = [
    "repo:dainmusty@179479146/document-retrieval-service-test@1358631211:*"
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
        "arn:aws:s3:::blueeagle-prod-app-doc-artifacts/document-retrieval-service/*"
       
      ]
    }

  ]

  tags = {
    Project = "document-retrieval-service-app"
    Owner   = "wandaprep"

  }
}


