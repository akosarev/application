terraform {
  backend "s3" {
    bucket = "backend-state-terraform-infrastructure"
    key    = "application/terraform.tfstate"
    region = "eu-west-1"
  }
}