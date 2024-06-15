# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and then run Terraform commands in that folder.
terraform {
  source = "../../../../../../../../modules/resource-group//."
}

# Include the root 'terragrunt.hcl' configuration. The root configuration contains settings that are common across all
# components and environments, such as how to configure remote state.
include "root" {
  path    = find_in_parent_folders()
  expose  = true
}

# Include the 'provider.hcl'. This file contains provider blocks generation and configuration.
include "provider" {
  path    = find_in_parent_folders("provider.hcl")
  expose  = true
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {
  resource_group_name  = "rg-${include.root.locals.organization}-${include.root.locals.project}-terragrunt-common"
  location             = "West Europe"
  storage_account_name = "${include.root.locals.project_shortname}tfstate"
  container_name       = "environment-tfstate"
}
