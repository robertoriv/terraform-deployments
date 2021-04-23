
include {
  path = find_in_parent_folders()
}

locals {
  env = try(yamldecode(file(find_in_parent_folders("env.yaml"))), {})
}

# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "git://github.com/terraform-aws-modules/terraform-aws-vpc//"
}

inputs = {
  name = "live-vpc-${local.env.environment_name}"
  tags = local.env.tags
}
