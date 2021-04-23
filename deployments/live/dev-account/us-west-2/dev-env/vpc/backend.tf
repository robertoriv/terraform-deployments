terraform {
  backend "s3" {
    bucket = "111122223333-us-west-2-tf-state"
    key    = "dev-account/us-west-2/dev-env/vpc/terraform.tfstate"
    region = "us-west-2"
  }
}
