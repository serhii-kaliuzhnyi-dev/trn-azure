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
  namespace_name = "${basename(dirname("${get_terragrunt_dir()}"))}"
  release_name   = "${basename(get_terragrunt_dir())}"
}

# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "git::https://github.com/terraform-module/terraform-helm-release.git//?ref=v2.8.2"
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

# Set module dependencies
dependency "namespace" {
  config_path = "${include.root.locals.clusters_path}/${include.provider.locals.name}/${include.instance.locals.name}/namespaces/${local.release_name}"
  mock_outputs = {
    name = "${local.namespace_name}"
  }
}


# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {
  namespace   = "${dependency.namespace.outputs.name}"
  # namespace   = "default"
  repository  = "https://charts.jetstack.io"

  app = {
    name           = "${local.release_name}"
    version        = "v1.15.0"
    chart          = "cert-manager"
    force_update   = true
    wait           = false
    recreate_pods  = false
    deploy         = 1
  }

  values = [
    "${file("${get_terragrunt_dir()}/values.yaml")}"
  ]

  set = [
    {
      name  = "global.commonLabels.organization"
      value = "${include.root.locals.organization}"
    },
    {
      name  = "global.commonLabels.project"
      value = "${include.root.locals.project}"
    },
    {
      name  = "global.commonLabels.environment"
      value = "${include.root.locals.environment}"
    },
    {
      name  = "global.commonLabels.managed_by"
      value = "terragrunt"
    },
    {
      name  = "crds.enabled"
      value = true
    }
  ]
}
