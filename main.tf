# Init backend

module "backend" {
  source = "./modules/resource-group"

  container_name = var.container_name
  storage_account_name = var.storage_account_name
  resource_group_name = var.resource_group_name
  location = var.location
}

module "networking" {
  source = "./modules/networking"

  resource_group_name = var.resource_group_name
  location            = var.location
}

module "aks" {
  source = "./modules/aks"

  resource_group_name       = module.backend.resource_group_name
  resource_group_location   = module.backend.resource_group_location
  cluster_name              = var.cluster_name
  node_count                = var.node_count
}

module "budget" {
  source = "./modules/budget"

  resource_group_name = var.resource_group_name
}
