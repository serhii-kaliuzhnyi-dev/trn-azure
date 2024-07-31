
variable "node_count" {
  type        = number
  description = "The initial quantity of nodes for the node pool."
  default     = 1
}

variable "username" {
  type        = string
  description = "The admin username for the new cluster."
  default     = "azureadmin"
}

variable "resource_group_location" {
  type        = string
  description = "Location of the resource group."
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group."
}

variable "cluster_name" {
  type        = string
  description = "Name of the Kubernetes cluster."
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