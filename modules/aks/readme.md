<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_kubernetes_cluster.k8s](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aad_client_app_id"></a> [aad\_client\_app\_id](#input\_aad\_client\_app\_id) | The Client Application ID for Azure Active Directory integration. | `string` | n/a | yes |
| <a name="input_aad_server_app_id"></a> [aad\_server\_app\_id](#input\_aad\_server\_app\_id) | The Server Application ID for Azure Active Directory integration. | `string` | n/a | yes |
| <a name="input_aad_server_app_secret"></a> [aad\_server\_app\_secret](#input\_aad\_server\_app\_secret) | The Server Application Secret for Azure Active Directory integration. | `string` | n/a | yes |
| <a name="input_aad_tenant_id"></a> [aad\_tenant\_id](#input\_aad\_tenant\_id) | The Tenant ID of the Azure Active Directory. | `string` | n/a | yes |
| <a name="input_admin_group_object_id"></a> [admin\_group\_object\_id](#input\_admin\_group\_object\_id) | The Object ID of the Azure AD group to be used for AKS admin access. | `string` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the Kubernetes cluster. | `string` | n/a | yes |
| <a name="input_node_count"></a> [node\_count](#input\_node\_count) | The initial quantity of nodes for the node pool. | `number` | `1` | no |
| <a name="input_oidc_issuer_enabled"></a> [oidc\_issuer\_enabled](#input\_oidc\_issuer\_enabled) | Enable or disable the OIDC issuer URL. | `bool` | `true` | no |
| <a name="input_resource_group_location"></a> [resource\_group\_location](#input\_resource\_group\_location) | Location of the resource group. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the resource group. | `string` | n/a | yes |
| <a name="input_username"></a> [username](#input\_username) | The admin username for the new cluster. | `string` | `"azureadmin"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_client_certificate"></a> [client\_certificate](#output\_client\_certificate) | n/a |
| <a name="output_client_key"></a> [client\_key](#output\_client\_key) | n/a |
| <a name="output_cluster_ca_certificate"></a> [cluster\_ca\_certificate](#output\_cluster\_ca\_certificate) | n/a |
| <a name="output_host"></a> [host](#output\_host) | n/a |
| <a name="output_kube_config"></a> [kube\_config](#output\_kube\_config) | n/a |
| <a name="output_kubernetes_cluster_name"></a> [kubernetes\_cluster\_name](#output\_kubernetes\_cluster\_name) | n/a |
<!-- END_TF_DOCS -->