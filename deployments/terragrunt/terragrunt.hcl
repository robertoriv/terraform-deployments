locals {
  aws_region = try(yamldecode(file(find_in_parent_folders("region.yaml"))), { aws_region = "us-west-2" }).aws_region
  account_id = try(yamldecode(file(find_in_parent_folders("account.yaml"))), {}).account_id
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region = "${local.aws_region}"
  allowed_account_ids = ["${local.account_id}"]
}
EOF
}

remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket         = "${get_aws_account_id()}-${local.aws_region}-tf-state"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = local.aws_region
    encrypt        = true
    dynamodb_table = "${get_aws_account_id()}-lock-table"
  }
}

inputs = merge(
  try(yamldecode(file(find_in_parent_folders("global.yaml"))), {}),   # global variables
  try(yamldecode(file(find_in_parent_folders("boundary.yaml"))), {}), # boundary-specific variables
  try(yamldecode(file(find_in_parent_folders("account.yaml"))), {}),  # account-specific variables
  try(yamldecode(file(find_in_parent_folders("region.yaml"))), {}),   # region-specific variables

  # deployment and env are equivalent (hierarchically)... env makes sense for infra; deployment makes more sense for application deployments
  try(yamldecode(file(find_in_parent_folders("deployment.yaml"))), {}), # deployment-specific variables
  try(yamldecode(file(find_in_parent_folders("env.yaml"))), {}),        # environment-specific variables

  try(yamldecode(file(find_in_parent_folders("overrides.yaml"))), {}), # overrides; may be eliminated
  try(yamldecode(file("overrides.yaml")), {}),                         # more overrides; may be aliminated
  {
    parent_terragrunt_dir = get_parent_terragrunt_dir(),
    terragrunt_dir        = get_terragrunt_dir(),
  }
)
