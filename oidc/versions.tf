terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.32.0"
    }
  }
  backend "s3" {
    bucket  = "s3-eks-iam-roles-repo-12-source"
    region  = "us-east-1"
    key     = "s3/terraform.tfstate"
    encrypt = true
  }
}