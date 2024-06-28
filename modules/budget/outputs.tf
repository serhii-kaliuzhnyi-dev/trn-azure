output "budget_ids" {
  value       = { for k, v in azurerm_consumption_budget_subscription.budget : k => v.id }
  description = "The IDs of the created budgets."
}
