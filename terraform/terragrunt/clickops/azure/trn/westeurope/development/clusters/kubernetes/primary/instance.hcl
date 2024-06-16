# Set common variables for the instance. This is automatically pulled in the root terragrunt.hcl configuration to
# configure the remote state bucket and pass forward to the child modules as inputs.
locals {
  # Set parameters to configure remote backend
  name      = join("/", [basename(dirname(dirname(get_terragrunt_dir())))])
}
