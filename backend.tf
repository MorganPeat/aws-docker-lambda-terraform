terraform {
  cloud {
    organization = "mp-demo-org"

    workspaces {
      name = "aws-docker-lambda-terraform"
    }
  }
}