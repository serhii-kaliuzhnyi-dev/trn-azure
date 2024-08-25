# Output for VM IDs
output "vm_ids" {
  description = "The IDs of the VMs created"
  value       = azurerm_linux_virtual_machine.vm[*].id
}

# Output for Network Interface IDs
output "nic_ids" {
  description = "The IDs of the Network Interfaces created"
  value       = azurerm_network_interface.nic[*].id
}

# Output for Private IP Addresses
output "private_ip_addresses" {
  description = "The private IP addresses of the VMs"
  value       = [for nic in azurerm_network_interface.nic : nic.private_ip_address]
}

# Output for Public IP Addresses (if applicable)
output "public_ip_addresses" {
  description = "The public IP addresses of the VMs"
  value       = [for pip in azurerm_public_ip.pip : pip.ip_address]
}
