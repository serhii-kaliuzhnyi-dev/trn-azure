<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.110.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 3.110.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_consumption_budget_subscription.budget](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/consumption_budget_subscription) | resource |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_budgets"></a> [budgets](#input\_budgets) | A map of budgets with their respective amounts. | `map(number)` | <pre>{<br/>  "MonthlyBudget": 10<br/>}</pre> | no |
| <a name="input_contact_emails"></a> [contact\_emails](#input\_contact\_emails) | List of email addresses to notify when the budget threshold is exceeded. | `list(string)` | <pre>[<br/>  "kalyuzhni.sergei@gmail.com"<br/>]</pre> | no |
| <a name="input_contact_groups"></a> [contact\_groups](#input\_contact\_groups) | List of Action Group IDs to notify when the budget threshold is exceeded. | `list(string)` | `[]` | no |
| <a name="input_contact_roles"></a> [contact\_roles](#input\_contact\_roles) | List of contact roles to notify when the budget threshold is exceeded. | `list(string)` | <pre>[<br/>  "Owner"<br/>]</pre> | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group. | `string` | n/a | yes |
| <a name="input_time_period_end_date"></a> [time\_period\_end\_date](#input\_time\_period\_end\_date) | The end date for the budget period. | `string` | `"2024-08-01T00:00:00Z"` | no |
| <a name="input_time_period_start_date"></a> [time\_period\_start\_date](#input\_time\_period\_start\_date) | The start date for the budget period. | `string` | `"2023-06-01T00:00:00Z"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_budget_ids"></a> [budget\_ids](#output\_budget\_ids) | The IDs of the created budgets. |
<!-- END_TF_DOCS -->