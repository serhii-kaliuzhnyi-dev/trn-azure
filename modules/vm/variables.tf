variable "name" {
  description = "Name prefix for the VM and associated resources"
  type        = string
}

variable "location" {
  description = "Azure location for the resources"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group in which to create the resources"
  type        = string
}

variable "subnets" {
  description = "List of subnet IDs where VMs will be deployed"
  type        = list(string)
}

variable "vm_size" {
  description = "The size of the VM instance"
  type        = string
}

variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
}

variable "ssh_public_key_path" {
  description = "Path to the SSH public key file"
  type        = string
}

variable "os_disk_type" {
  description = "The type of OS disk"
  type        = string
  default     = "Standard_LRS"
}

variable "image_publisher" {
  description = "Publisher of the image to use"
  type        = string
  default     = "Canonical"
}

variable "image_offer" {
  description = "Offer of the image to use"
  type        = string
  default     = "0001-com-ubuntu-server-jammy"
}

variable "image_sku" {
  description = "SKU of the image to use"
  type        = string
  default     = "22_04-lts"
}

variable "image_version" {
  description = "Version of the image to use"
  type        = string
  default     = "latest"
}

variable "tags" {
  description = "Tags to apply to the resources"
  type        = map(string)
  default     = {}
}

variable "public_ip" {
  description = "Boolean to indicate if public IP should be assigned"
  type        = bool
  default     = false
}
