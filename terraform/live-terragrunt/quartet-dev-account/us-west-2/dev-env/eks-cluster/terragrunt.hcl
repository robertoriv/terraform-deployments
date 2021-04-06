locals {
  env = try(yamldecode(file(find_in_parent_folders("env.yaml"))), {})
}

# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "${get_parent_terragrunt_dir()}/../modules/eks"
}

include {
  path = find_in_parent_folders()
}

dependencies {
  paths = ["../vpc"]
}

dependency "vpc" {
  config_path = "../vpc"
  mock_outputs = {
    vpc_id = "fake-vpc-id"
    subnet_ids = [
      "fake-subnet-id-1",
      "fake-subnet-id-2"
    ]
  }
}

inputs = {
  cluster_name = "${local.env.eks_cluster_name_prefix}-${local.env.environment_name}"
  vpc_id       = dependency.vpc.outputs.vpc_id
  subnet_ids   = dependency.vpc.outputs.subnet_ids
}
