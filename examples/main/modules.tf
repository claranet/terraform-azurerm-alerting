module "alerting" {
  source  = "claranet/alerting/azurerm"
  version = "x.x.x"

  location_short = module.azure_region.location_short
  client_name    = var.client_name
  environment    = var.environment
  stack          = var.stack

  resource_group_name     = module.rg.name
  action_group_short_name = "Alerting"

  action_group_webhooks = {
    PagerDuty = "https://events.pagerduty.com/integration/{integration-UID}/enqueue"
    Slack     = "https://hooks.slack.com/services/{azerty}/XXXXXXXXXXXXXXx/{hook-key}"
  }

  activity_log_alerts = {
    "service-health" = {
      description         = "ServiceHealth global Subscription alerts"
      resource_group_name = module.rg.name
      scopes              = [format("/subscriptions/%s", var.azure_subscription_id)]
      criteria = {
        category = "ServiceHealth"
      }
    }

    "security-center" = {
      custom_name         = "${var.stack}-global-security-center"
      description         = "Security Center global Subscription alerts"
      resource_group_name = module.rg.name
      scopes              = [format("/subscriptions/%s", var.azure_subscription_id)]
      criteria = {
        category = "Security"
        level    = "Error"
      }
    }

    "advisor" = {
      custom_name         = "${var.stack}-global-advisor-alerts"
      description         = "Advisor global Subscription alerts"
      resource_group_name = module.rg.name
      scopes              = [format("/subscriptions/%s", var.azure_subscription_id)]
      criteria = {
        category = "Recommendation"
        level    = "Informational"
      }
    }

    "managed-disks" = {
      custom_name         = "${var.stack}-global-managed-disks-alerts"
      description         = "Azure disks movements alerts"
      resource_group_name = module.rg.name
      scopes              = [format("/subscriptions/%s", var.azure_subscription_id)]
      criteria = {
        category      = "Administrative"
        resource_type = "Microsoft.Compute/disks"
        level         = "Informational"
        status        = "Succeeded"
      }
    }
  }

  metric_alerts = {
    "cpu-usage" = {
      description         = "CPU usage alert"
      resource_group_name = module.rg.name
      scopes = [
        format("/subscriptions/%s/resourceGroups/%s/providers/Microsoft.Compute/virtualMachines/%s", var.azure_subscription_id, module.rg.name, "myVM")
      ]
      criteria = [
        {
          metric_namespace = "Microsoft.Compute/virtualMachines"
          metric_name      = "Percentage CPU"
          aggregation      = "Total"
          operator         = "GreaterThan"
          threshold        = 80
        }
      ]
    }
  }

  extra_tags = {
    purpose = "alerting testing"
  }
}
