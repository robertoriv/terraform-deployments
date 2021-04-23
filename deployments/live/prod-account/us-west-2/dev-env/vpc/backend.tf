terraform {
  backend "s3" {
    bucket = "111122223333-us-west-2-tf-state"
    key    = "prod-account/us-west-2/prod-env/vpc/terraform.tfstate"
    region = "us-west-2"
  }
}
