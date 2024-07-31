# Init backend

module "backend" {
  source = "./modules/resource-group"

  container_name = var.container_name
  storage_account_name = var.storage_account_name
  resource_group_name = var.resource_group_name
  location = var.location
  create_resources = false
}

# module "networking" {
#   source = "./modules/networking"

#   resource_group_name = var.resource_group_name
#   location            = var.location
# }

module "aks" {
  source = "./modules/aks"

  resource_group_name       = module.backend.resource_group_name
  resource_group_location   = module.backend.resource_group_location
  cluster_name              = var.cluster_name
  node_count                = var.node_count
  aad_tenant_id = var.aad_tenant_id
  aad_server_app_id = var.aad_server_app_id
  aad_server_app_secret = var.aad_server_app_secret
  aad_client_app_id = var.aad_client_app_id
  admin_group_object_id = var.admin_group_object_id
}

module "flux" {
  source = "./modules/flux"
  depends_on = [module.aks]
}


# module "budget" {
#   source = "./modules/budget"

#   resource_group_name = var.resource_group_name
# }


module "acr" {
  source              = "./modules/acr"
  acr_name            = "trnimagestorage"
  resource_group_name = module.backend.resource_group_name
  location            = module.backend.resource_group_location
}

module "github" {
  source             = "./modules/github"
  repository_name    = "go-server-canary"
  acr_login_server   = module.acr.acr_login_server
  acr_username       = module.acr.acr_admin_username
  acr_password       = module.acr.acr_admin_password
  client_id          = var.client_id
  client_secret      = var.client_secret
  subscription_id    = var.subscription_id
  tenant_id          = var.tenant_id
  github_token       = var.github_token
}