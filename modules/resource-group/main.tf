resource "azurerm_resource_group" "this" {
  count    = var.create_resources ? 1 : 0
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_storage_account" "this" {
  count                    = var.create_storage_account ? 1 : 0
  name                     = var.storage_account_name
  resource_group_name      = var.create_resources ? azurerm_resource_group.this[0].name : var.resource_group_name
  location                 = var.create_resources ? azurerm_resource_group.this[0].location : var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
}

resource "azurerm_storage_container" "this" {
  count                 = var.create_storage_container ? 1 : 0
  name                  = var.container_name
  storage_account_name  = var.create_storage_account ? azurerm_storage_account.this[0].name : var.storage_account_name
  container_access_type = "private"
}

data "azurerm_resource_group" "this" {
  count = var.create_resources ? 0 : 1
  name  = var.resource_group_name
}

data "azurerm_storage_account" "this" {
  count               = var.create_storage_account ? 0 : 1
  name                = var.storage_account_name
  resource_group_name = var.resource_group_name
}

data "azurerm_storage_container" "this" {
  count                = var.create_storage_container ? 0 : 1
  name                 = var.container_name
  storage_account_name = var.storage_account_name
}
