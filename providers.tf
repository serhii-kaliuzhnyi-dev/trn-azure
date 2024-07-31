provider "azurerm" {
  features {}
}

provider "helm" {
  kubernetes {
    config_path = "${path.module}/kubeconfig"
  }
}

resource "local_file" "kubeconfig" {
  content  = module.aks.kube_config
  filename = "${path.module}/kubeconfig"
}

provider "kubernetes" {
  config_path = local_file.kubeconfig.filename
}

provider "github" {
  token = var.github_token
}