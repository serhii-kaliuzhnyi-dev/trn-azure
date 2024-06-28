data "azurerm_subscription" "current" {}

resource "azurerm_consumption_budget_subscription" "budget" {
  for_each        = var.budgets

  name            = each.key
  subscription_id = data.azurerm_subscription.current.id
  amount          = each.value
  time_grain      = "BillingMonth"

  time_period {
    start_date = var.time_period_start_date
    end_date   = var.time_period_end_date
  }

  notification {
    threshold    = 80
    operator     = "GreaterThan"
    threshold_type = "Actual"
    contact_emails = var.contact_emails
    contact_groups = var.contact_groups
    contact_roles  = var.contact_roles
  }

  notification {
    threshold    = 100
    operator     = "GreaterThan"
    threshold_type = "Forecasted"
    contact_emails = var.contact_emails
  }
}
