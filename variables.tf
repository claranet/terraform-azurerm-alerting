variable "location_short" {
  description = "Short string for Azure location."
  type        = string
}

variable "client_name" {
  description = "Client name/account used in naming."
  type        = string
}

variable "environment" {
  description = "Project environment."
  type        = string
}

variable "stack" {
  description = "Project stack name."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name."
  type        = string
}

variable "action_group_webhooks" {
  description = "Map of Webhooks to notify. Example: `{ PagerDuty = 'https://events.pagerduty.com/integration/abcdefgh12345azerty/enqueue' }`."
  type        = map(string)
  default     = {}
}

variable "action_group_emails" {
  description = "Map of Emails to notify. Example: `{ ml-devops = devops@contoso.com }`."
  type        = map(string)
  default     = {}
}

variable "activity_log_alerts" {
  description = "Map of Activity log Alerts."
  type = map(object({
    description         = optional(string)
    custom_name         = optional(string)
    resource_group_name = optional(string)
    scopes              = list(string)
    criteria = object({
      operation_name = optional(string)
      category       = optional(string, "Recommendation")
      level          = optional(string, "Error")
      status         = optional(string)

      resource_provider = optional(string)
      resource_type     = optional(string)
      resource_group    = optional(string)
      resource_id       = optional(string)
    })
  }))
  default = {}
}

variable "service_health" {
  description = "A block supports the following: `events`, `locations` and `services`. https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_activity_log_alert"
  type = object({
    events    = optional(string, "Incident")
    locations = optional(string, "Global")
    services  = optional(string)
  })
  default = null
}
