terraform {
  backend "s3" {
    bucket = "111122223333-us-west-2-tf-state"
    key    = "dev-account/us-west-2/dev-env/web-server/terraform.tfstate"
    region = "us-west-2"
  }
}

provider "aws" {
  region = var.region
}

variable "region" {
  description = "region"
}

data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = "111122223333-us-west-2-tf-state"
    key    = "dev-account/us-west-2/dev-env/vpc/terraform.tfstate"
    region = "us-west-2"
  }
}

module "web-server" {
  source = "../../../../../../modules/web-server/"

  environment_name = "dev"
  vpc_id           = data.terraform_remote_state.vpc.outputs.vpc_id
  subnet           = data.terraform_remote_state.vpc.outputs.public_subnets[0]
  ami_id           = "ami-090717c950a5c34d3"
}

output "instance_ip" {
  value = module.web-server.public_ip
}
