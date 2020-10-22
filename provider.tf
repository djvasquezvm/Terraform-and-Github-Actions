terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }

  backend "s3" {
    bucket         = "terraform-up-and-running-state-daniel-vasquez"
    key            = "global/s3/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-up-and-running-locks-daniel-vasquez"
    encrypt        = true
  }

}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}
