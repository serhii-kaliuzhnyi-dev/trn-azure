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
| [azurerm_virtual_network_peering.peer](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `string` | n/a | yes |
| <a name="input_source_vnet_name"></a> [source\_vnet\_name](#input\_source\_vnet\_name) | n/a | `string` | n/a | yes |
| <a name="input_target_vnet_id"></a> [target\_vnet\_id](#input\_target\_vnet\_id) | n/a | `string` | n/a | yes |
| <a name="input_target_vnet_name"></a> [target\_vnet\_name](#input\_target\_vnet\_name) | n/a | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->