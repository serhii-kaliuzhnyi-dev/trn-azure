resource "azurerm_kubernetes_cluster" "k8s" {
  location            = var.resource_group_name
  name                = var.cluster_name
  resource_group_name = var.resource_group_location

  default_node_pool {
    name       = "default"
    vm_size    = "Standard_D2_v2"
    node_count = var.node_count
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = "standard"
  }
}