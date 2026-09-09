
module "gitactions_tf_role" {

  source = "../modules/gitactions-role"

  role_name            = "gitactions-tf-role"
  create_oidc_provider = false

  github_oidc_subjects = [
    "repo:dainmusty@179479146/document-retrieval-service-test@1358631211:*"   # remember to update this to your repo with the owner and repo ids and branch name
  ]

  inline_policy_statements = [



    #########################################
    # S3
    #########################################
    {
      Sid    = "AllowedS3Actions"
      Effect = "Allow"

      Action = [

        "s3:PutObject", "s3:ListObjects"

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


