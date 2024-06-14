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
  source = "../../../modules/resource-group//."
}

inputs = {
  name                          = "iris"
  environment                   = local.environment

  resource_group_name    = "trn"
  location               = "East US"
  storage_account_name   = "trn"
  container_name         = "trn-state"
}
