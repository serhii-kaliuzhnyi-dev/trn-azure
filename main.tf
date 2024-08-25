# Init backend

module "backend" {
  source = "./modules/resource-group"

  container_name = var.container_name
  storage_account_name = var.storage_account_name
  resource_group_name = var.resource_group_name
  location = var.location
  create_resources = false
}

module "shared_network" {
  source = "./modules/networking"

  name                = "shared-vnet"
  address_space       = "10.1.0.0/16"
  location            = var.location
  resource_group_name = var.resource_group_name
}

module "main_network" {
  source = "./modules/networking"

  name                = "main-vnet"
  address_space       = "10.2.0.0/16"
  location            = var.location
  resource_group_name = var.resource_group_name
}

module "shared_to_main_peering" {
  source = "./modules/peering"

  resource_group_name = var.resource_group_name
  source_vnet_name    = module.shared_network.vnet.name
  target_vnet_name    = module.main_network.vnet.name
  target_vnet_id      = module.main_network.vnet.id
}

module "main_to_shared_peering" {
  source = "./modules/peering"

  resource_group_name = var.resource_group_name
  source_vnet_name    = module.main_network.vnet.name
  target_vnet_name    = module.shared_network.vnet.name
  target_vnet_id      = module.shared_network.vnet.id
}

module "private_vm" {
  source = "./modules/vm"

  name                = "private-vm"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnets             = [tolist(module.shared_network.vnet.subnet)[0].id]
  vm_size             = "Standard_F2"
  admin_username      = "admin"
  ssh_public_key_path = "~/.ssh/id_rsa.pub"
  public_ip           = false
}

module "public_vm" {
  source = "./modules/vm"

  name                = "public-vm"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnets             = [tolist(module.main_network.vnet.subnet)[0].id]
  vm_size             = "Standard_F2"
  admin_username      = "admin"
  ssh_public_key_path = "~/.ssh/id_rsa.pub"
  public_ip           = true
}


# module "aks" {
#   source = "./modules/aks"

#   resource_group_name       = module.backend.resource_group_name
#   resource_group_location   = module.backend.resource_group_location
#   cluster_name              = var.cluster_name
#   node_count                = var.node_count
#   aad_tenant_id = var.aad_tenant_id
#   aad_server_app_id = var.aad_server_app_id
#   aad_server_app_secret = var.aad_server_app_secret
#   aad_client_app_id = var.aad_client_app_id
#   admin_group_object_id = var.admin_group_object_id
# }

# module "budget" {
#   source = "./modules/budget"

#   resource_group_name = var.resource_group_name
# }


# module "acr" {
#   source              = "./modules/acr"
#   acr_name            = "trnimagestorage"
#   resource_group_name = module.backend.resource_group_name
#   location            = module.backend.resource_group_location
# }

# module "flux" {
#   source = "./modules/flux"
#   acr_login_server = module.acr.acr_login_server
#   acr_admin_username = module.acr.acr_admin_username
#   acr_admin_password = module.acr.acr_admin_password
#   depends_on = [module.aks, module.acr]
# }


# module "github" {
#   source             = "./modules/github"
#   repository_name    = "go-server-canary"
#   acr_login_server   = module.acr.acr_login_server
#   acr_username       = module.acr.acr_admin_username
#   acr_password       = module.acr.acr_admin_password
#   client_id          = var.client_id
#   client_secret      = var.client_secret
#   subscription_id    = var.subscription_id
#   tenant_id          = var.tenant_id
#   github_token       = var.github_token
# }