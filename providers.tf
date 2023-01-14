# Configure the Docker & AWS Providers
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.20.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.20"
    }
  }
}

provider "docker" {}

provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_access_key
}