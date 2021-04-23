
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "simple-vpc-${var.environment_name}"
  cidr = var.vpc_cidr

  azs             = var.availability_zones
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Environment = var.environment_name
  }
}

module "web-server" {
  source = "../../modules/web-server"

  environment_name = var.environment_name
  vpc_id           = module.vpc.vpc_id
  subnet           = module.vpc.public_subnets[0]
  ami_id           = var.ami_id
}
