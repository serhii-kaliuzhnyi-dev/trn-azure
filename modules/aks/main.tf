resource "azurerm_kubernetes_cluster" "k8s" {
  location            = var.resource_group_location
  name                = var.cluster_name
  resource_group_name = var.resource_group_name
  dns_prefix          = var.cluster_name

  default_node_pool {
    name       = "default"
    vm_size    = "Standard_D2_v2"
    node_count = var.node_count
  }

  sku_tier = "Standard"
  
  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = "standard"
  }

  azure_active_directory_role_based_access_control {
    managed     = true
    tenant_id             = var.aad_tenant_id
    admin_group_object_ids = [
      var.admin_group_object_id
    ]
  }

  oidc_issuer_enabled = var.oidc_issuer_enabled
}
