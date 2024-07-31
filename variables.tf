variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location of the resource group"
  type        = string
}

variable "cluster_name" {
  description = "The name of the AKS cluster"
  type        = string
}

variable "node_count" {
  description = "The number of nodes in the AKS cluster"
  type        = number
}

variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
}

variable "container_name" {
  description = "The name of the storage container"
  type        = string
}

variable "aad_tenant_id" {
  description = "The Tenant ID of the Azure Active Directory."
  type        = string
}

variable "aad_server_app_id" {
  description = "The Server Application ID for Azure Active Directory integration."
  type        = string
}

variable "aad_server_app_secret" {
  description = "The Server Application Secret for Azure Active Directory integration."
  type        = string
}

variable "aad_client_app_id" {
  description = "The Client Application ID for Azure Active Directory integration."
  type        = string
}

variable "admin_group_object_id" {
  description = "The Object ID of the Azure AD group to be used for AKS admin access."
  type = string
}

variable "oidc_issuer_enabled" {
  description = "Enable or disable the OIDC issuer URL."
  type        = bool
  default     = true
}

variable "github_token" {
  type        = string
  description = "Your GitHub personal access token"
  sensitive   = true
}

variable "client_id" {
  description = "Azure client ID"
  type        = string
}

variable "client_secret" {
  description = "Azure client secret"
  type        = string
}

variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
}

variable "tenant_id" {
  description = "Azure tenant ID"
  type        = string
}