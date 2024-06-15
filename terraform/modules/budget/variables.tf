variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "budgets" {
  description = "A map of budgets with their respective amounts."
  type        = map(number)
  default     = {
    MonthlyBudget = 50
  }
}

variable "contact_emails" {
  description = "List of email addresses to notify when the budget threshold is exceeded."
  type        = list(string)
  default     = ["kalyuzhni.sergei@gmail.com"]
}

variable "contact_groups" {
  description = "List of Action Group IDs to notify when the budget threshold is exceeded."
  type        = list(string)
  default     = []
}

variable "contact_roles" {
  description = "List of contact roles to notify when the budget threshold is exceeded."
  type        = list(string)
  default     = ["Owner"]
}

variable "time_period_start_date" {
  description = "The start date for the budget period."
  type        = string
  default     = "2023-06-01T00:00:00Z"
}

variable "time_period_end_date" {
  description = "The end date for the budget period."
  type        = string
  default     = "2024-07-01T00:00:00Z"
}
