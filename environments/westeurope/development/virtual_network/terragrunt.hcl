include "root" {
  path = find_in_parent_folders()
}

locals {
  environment_config = read_terragrunt_config(find_in_parent_folders("environment.hcl"))
  environment        = local.environment_config.locals.environment
  region             = local.environment_config.locals.azure_region
  domain_name        = local.environment_config.locals.domain_name
}

terraform {
  source = "../../../modules/virtual_network//."
}

dependency "resource_group" {
  config_path                             = "../resource_group/"
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan", "terragrunt-info", "show"] # Configure mock outputs for the "init", "validate", "plan", etc. commands that are returned when there are no outputs available (e.g the module hasn't been applied yet.)
  mock_outputs = {
    resource_group_name = "fake-resource-group-name"
  }
}

inputs = {
  name                          = "trn"
  environment                   = local.environment

  resource_group_name           = dependency.resource_group.outputs.resource_group_name
}
