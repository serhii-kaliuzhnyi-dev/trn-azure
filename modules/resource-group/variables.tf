variable "create_resources" {
  description = "Whether to create new resources or use existing ones."
  type        = bool
  default     = true
}

variable "create_storage_account" {
  description = "Whether to create a new storage account."
  type        = bool
  default     = false
}

variable "create_storage_container" {
  description = "Whether to create a new storage container."
  type        = bool
  default     = false
}

variable "resource_group_name" {
  description = "Name of the resource group."
  type        = string
}

variable "location" {
  description = "Location of the resource group."
  type        = string
}

variable "storage_account_name" {
  description = "Name of the storage account."
  type        = string
}

variable "account_tier" {
  description = "Tier of the storage account."
  type        = string
  default     = "Standard"
}

variable "account_replication_type" {
  description = "Replication type of the storage account."
  type        = string
  default     = "LRS"
}

variable "container_name" {
  description = "Name of the storage container."
  type        = string
}
