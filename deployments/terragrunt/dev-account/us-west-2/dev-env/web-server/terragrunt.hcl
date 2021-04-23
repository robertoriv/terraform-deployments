include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../../../modules/web-server//"
}

# When applying this module, we need to rely on values that come from the vpc module (replaces `data "terraform_remote_state" "vpc"`)
dependency "vpc" {
  config_path = "../vpc"

  # Configure mock outputs for the `validate`, `plan` commands that are returned when there are no outputs available (e.g the module hasn't been applied yet.
  mock_outputs_allowed_terraform_commands = ["validate", "plan"]
  mock_outputs = {
    vpc_id            = "fake-vpc-id"
    public_subnets = ["subnet-fake1", "subnet-fake2"]
  }
}

# When applying this terragrunt config in an `run-all` command, make sure the vpc module is handled first.
dependencies {
  paths = ["../vpc"]
}

inputs = {
  vpc_id = dependency.vpc.outputs.vpc_id
  subnet = dependency.vpc.outputs.public_subnets[0]
}
