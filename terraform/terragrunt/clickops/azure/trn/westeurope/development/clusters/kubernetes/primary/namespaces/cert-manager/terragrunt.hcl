# -----------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# Terragrunt is a thin wrapper for Terraform that provides extra tools for working with multiple Terraform modules,
# remote state, and locking: https://github.com/gruntwork-io/terragrunt
# -----------------------------------------------------------------------------------------------------------------

# The locals block does not have a defined set of arguments that are supported.
# Instead, all the arguments passed into locals are available under the reference local.ARG_NAME
# throughout the Terragrunt configuration.

locals {
  # Set local variables
  namespace_name = "${basename(get_terragrunt_dir())}"
}

# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "git::https://github.com/gruntwork-io/terraform-kubernetes-namespace.git//modules/namespace?ref=v0.5.1"
}

# Include the root 'terragrunt.hcl' configuration. The root configuration contains settings that are common across all
# components and environments, such as how to configure remote state.
include "root" {
  path = find_in_parent_folders()
  expose = true
}

# Include the 'provider.hcl'. This file contains provider blocks generation and configuration.
include "provider" {
  path = find_in_parent_folders("provider.hcl")
  expose = true
}

# Include the 'instance.hcl'. This file contains instance specific variables, global dependencies... etc.
include "instance" {
  path = find_in_parent_folders("instance.hcl")
  expose = true
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {
  name = "${local.namespace_name}"
  kubectl_config_path = "~/.kube/config"
  kubectl_config_context_name= "trn-cluster"
}
