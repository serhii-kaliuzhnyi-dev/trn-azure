output "vnet_id" {
  description = "The ID of the Virtual Network"
  value       = azurerm_virtual_network.vnet.id
}

output "subnet_id" {
  description = "The ID of the Subnet"
  value       = azurerm_subnet.subnet.id
}

output "nic_id" {
  description = "The ID of the Network Interface"
  value       = azurerm_network_interface.nic.id
}

output "public_ip" {
  description = "The Public IP address"
  value       = azurerm_public_ip.pip.ip_address
}
