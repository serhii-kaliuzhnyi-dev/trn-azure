# Set common variables for the provider. This is automatically pulled in the root terragrunt.hcl configuration to
# configure the remote state bucket and pass forward to the child modules as inputs.
locals {
  # Set parameters to configure provider
  name = basename(get_parent_terragrunt_dir())

  # Automatically load location-level variables
  location_vars = read_terragrunt_config(find_in_parent_folders("location.hcl"))

  # Configure secrets paths for terragrunt
  supplier_secrets_path = "${get_repo_root()}/secrets/${trimsuffix(replace(get_path_from_repo_root(), "/^\\/+|\\/+$/g", ""), path_relative_to_include())}"

  # Automatically load secret variables
  secrets_vars = try(yamldecode(sops_decrypt_file("${local.supplier_secrets_path}/secrets.sops.yaml")), {})
}

# Generate provider block
# generate "provider" {
#   path      = "provider.tf"
#   if_exists = "overwrite_terragrunt"

#   contents = <<EOF
#     provider "kubectl" {}
#   EOF
# }
