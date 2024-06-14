locals {
  environment_config = read_terragrunt_config(find_in_parent_folders("environment.hcl"))
  environment        = local.environment_config.locals.environment
  region             = local.environment_config.locals.azure_region
  domain_name        = local.environment_config.locals.domain_name
}

remote_state {
  backend = "azurerm"
  generate = {
    path      = "_backend.tf"
    if_exists = "overwrite"
  }

  config = {
    resource_group_name   = "trn"
    storage_account_name  = "trn"
    container_name        = "trn-state"
    key                   = "${path_relative_to_include()}/terraform.tfstate"
  }
}

inputs = {
  azure_region  = local.region
  environment = local.environment
}

generate "myconfig" {
  path      = "_config.tf"
  if_exists = "overwrite"

  contents = <<EOF
provider "azurerm" {
    features {}
}
EOF
}

terraform {
  extra_arguments "common_vars" {
    commands = get_terraform_commands_that_need_vars()
  }
}
