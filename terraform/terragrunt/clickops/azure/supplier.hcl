# Set common variables for the supplier. This is automatically pulled in the root terragrunt.hcl configuration to
# configure the remote state bucket and pass forward to the child modules as inputs.
locals {
  # Set parameters to configure remote backend
  name      = "${basename(get_terragrunt_dir())}"
  shortname = "azure"
  backend   = "azurerm"
}
