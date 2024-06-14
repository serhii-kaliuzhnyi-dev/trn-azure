locals {
  environment      = "${basename(get_terragrunt_dir())}"
  azure_region     = "westeurope"
  domain_name      = "clickops.life"
}
