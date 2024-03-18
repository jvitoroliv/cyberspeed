terraform {
  backend "s3" {
    bucket = "cyberspeed-project-tfstate"
    key    = "cyberspeed/project/tfstate"
    region = "us-east-1"
  }
}