# -----------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# Terragrunt is a thin wrapper for Terraform that provides extra tools for working with multiple Terraform modules,
# remote state, and locking: https://github.com/gruntwork-io/terragrunt
# -----------------------------------------------------------------------------------------------------------------

# The locals block does not have a defined set of arguments that are supported.
# Instead, all the arguments passed into locals are available under the reference local.ARG_NAME
# throughout the Terragrunt configuration.

locals {
  # Track changes in yaml and tpl files with atlantis
  extra_atlantis_dependencies = [
    "*.yaml",
    "*.tpl",
  ]

  # Automatically load organization-level variables
  organization_vars = read_terragrunt_config(find_in_parent_folders("organization.hcl"))

  # Automatically load supplier-level variables
  supplier_vars = read_terragrunt_config(find_in_parent_folders("supplier.hcl"))

  # Automatically load project-level variables
  project_vars = read_terragrunt_config(find_in_parent_folders("project.hcl"))

  # Automatically load location-level variables
  location_vars = read_terragrunt_config(find_in_parent_folders("location.hcl"))

  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("environment.hcl"))

  # Extract the variables we need for easy access
  organization                       = "${local.organization_vars.locals.name}"
  organization_shortname             = "${local.organization_vars.locals.shortname}"
  supplier                           = "${local.supplier_vars.locals.name}"
  supplier_shortname                 = "${local.supplier_vars.locals.shortname}"
  backend                            = "${local.supplier_vars.locals.backend}"
  project                            = "${local.project_vars.locals.name}"
  project_shortname                  = "${local.project_vars.locals.shortname}"
  location                           = "${local.location_vars.locals.name}"
  location_shortname                 = "${local.location_vars.locals.shortname}"
  environment                        = "${local.environment_vars.locals.name}"
  environment_shortname              = "${local.environment_vars.locals.shortname}"
  common_prefix                      = "${local.project_shortname}-${local.location_shortname}-${local.environment_shortname}"
  common_prefix_short                = "${local.project_shortname}${local.location_shortname}${local.environment_shortname}"
  prefix                             = "${local.common_prefix}-${local.organization_shortname}"
  infrastructure_domain              = "${local.environment}.${local.organization_vars.locals.infrastructure_domain}"
  infrastructure_domain_suffix       = "${local.organization_shortname}.${local.infrastructure_domain}"
  infrastructure_domain_suffix_short = "${local.environment_shortname}.${local.supplier_shortname}.${local.infrastructure_domain}"
  organization_domain                = "${local.organization_vars.locals.organization_domain}"
  organization_domain_suffix         = "${local.environment}.${local.organization_domain}"
  organization_domain_suffix_short   = "${local.environment_shortname}.${local.supplier_shortname}.${local.organization_domain}"

  # Configure secrets paths for terragrunt
  secrets_path          = "${get_repo_root()}/secrets"
  supplier_secrets_path = "${local.secrets_path}/${local.organization}/${local.supplier}"

  # Automatically load secret variables
  secret_vars = try(yamldecode(sops_decrypt_file("${local.supplier_secrets_path}/secrets.sops.yaml")), {})

  # Configure common paths for terragrunt
  project_path             = "${get_parent_terragrunt_dir()}/${local.organization}/${local.supplier}/${local.project}"
  environment_path         = "${local.project_path}/${local.location}/${local.environment}"
  applications_path        = "${local.environment_path}/applications"
  clusters_path            = "${local.environment_path}/clusters"
  resources_path           = "${local.environment_path}/resources"
  common_path              = "${local.project_path}/global/common"
  common_applications_path = "${local.common_path}/applications"
  common_clusters_path     = "${local.common_path}/clusters"
  common_resources_path    = "${local.common_path}/resources"

  # Default tags for all resources
  tags_map = {
    managed_by   = "terragrunt"
    organization = "${local.organization}"
    project      = "${local.project}"
    location     = "${local.location}"
    environment  = "${local.environment}"
  }

  tags_list = [
    "terragrunt",
    "${local.organization}",
    "${local.project}",
    "${local.location}",
    "${local.environment}"
  ]

  # Generate remote config to store tfstates remotely
  backend_config = {
    "azure" = {
      # TODO Need to create service principal, but it requires some permissions

      # client_id            = "${try(local.secret_vars.CLIENT_ID, null)}"
      # client_secret        = "${try(local.secret_vars.CLIENT_SECRET, null)}"
      tenant_id            = "${try(local.secret_vars.TENANT_ID, null)}"
      subscription_id      = "${try(local.secret_vars.SUBSCRIPTION_ID, null)}"
      key                  = "${path_relative_to_include()}/terraform.tfstate"
      resource_group_name  = "rg-${local.organization}-${local.project}-terragrunt-common"
      storage_account_name = "${local.project_shortname}tfstate"
      container_name       = "environment-tfstate"
    }
  }
}

remote_state {
  backend      = "${local.backend}"
  config       = lookup(local.backend_config, local.supplier, null)
  disable_init = false
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# GLOBAL PARAMETERS
# These variables apply to all configurations in this subfolder. These are automatically merged into the child
# 'terragrunt.hcl' config via the include block.
# ---------------------------------------------------------------------------------------------------------------------

# Configure root level variables that all resources can inherit. This is especially helpful with multi-account configs
# where terraform_remote_state data sources are placed directly into the modules.
inputs = merge(
  local.organization_vars.locals,
  local.supplier_vars.locals,
  local.project_vars.locals,
  local.location_vars.locals,
  local.environment_vars.locals,
)
