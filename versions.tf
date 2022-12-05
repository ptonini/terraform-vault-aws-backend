terraform {
  required_providers {
    vault = {
      source = "hashicorp/vault"
      version = ">= 3.11.0"
    }
    aws = {
      source = "hashicorp/aws"
    }
  }
}