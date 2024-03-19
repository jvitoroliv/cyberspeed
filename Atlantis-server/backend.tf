terraform {
  backend "s3" {
    bucket = "cyberspeed-project-tfstate"
    key    = "cyberspeed/atlantis-server/tfstate"
    region = "us-east-1"
  }
}