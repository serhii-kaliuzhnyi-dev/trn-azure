output "resource_group_name" {
  value = var.create_resources ? azurerm_resource_group.this[0].name : data.azurerm_resource_group.this[0].name
}

output "resource_group_location" {
  value = var.create_resources ? azurerm_resource_group.this[0].location : data.azurerm_resource_group.this[0].location
}

output "storage_account_name" {
  value = var.create_storage_account ? azurerm_storage_account.this[0].name : data.azurerm_storage_account.this[0].name
}

output "storage_container_name" {
  value = var.create_storage_container ? azurerm_storage_container.this[0].name : data.azurerm_storage_container.this[0].name
}
