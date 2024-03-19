terraform {
  required_version = ">= 0.13.1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.8.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 3.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.10"
    }
  }
  backend "s3" {
    bucket = "cyberspeed-project-tfstate"
    key    = "cyberspeed/project-test/tfstate"
    region = "us-east-1"
  }
}