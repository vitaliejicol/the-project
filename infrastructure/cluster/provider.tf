terraform {
#   cloud {
#     organization = "vitaliejicol"

#     workspaces {
#       name = "test"
#     }
#   }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.38.0"
    }

    rhcs = {
      source  = "terraform-redhat/rhcs"
      version = ">= 1.7.2"

    }
  }
}

provider "aws" {
  region = "us-east-1"
}

provider "rhcs" {
  token = var.rhcs_token
}
