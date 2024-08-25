terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.0.1"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  client_id = var.client_id
  client_secret = var.client_secret
  tenant_id = var.tenant_id
}

# provider "helm" {
#   kubernetes {
#     config_path = "${path.module}/kubeconfig"
#   }
# }

# resource "local_file" "kubeconfig" {
#   content  = module.aks.kube_config
#   filename = "${path.module}/kubeconfig"
# }

# provider "kubernetes" {
#   config_path = local_file.kubeconfig.filename
# }

# provider "github" {
#   token = var.github_token
# }