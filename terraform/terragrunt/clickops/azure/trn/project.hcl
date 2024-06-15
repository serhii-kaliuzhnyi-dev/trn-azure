# Set common variables for the project. This is automatically pulled in the root terragrunt.hcl configuration to
# configure the remote state bucket and pass forward to the child modules as inputs.
locals {
  name      = "${basename(get_terragrunt_dir())}"
  shortname = "${substr(local.name, 0, 3)}"
}
