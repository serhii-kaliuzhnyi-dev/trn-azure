# Set common variables for the location. This is automatically pulled in the root terragrunt.hcl configuration to
# configure the remote state bucket and pass forward to the child modules as inputs.
locals {
  name      = "westeurope"
  shortname = "we"
}
