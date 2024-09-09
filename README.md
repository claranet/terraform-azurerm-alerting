# Azure Alerting
[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md) [![Notice](https://img.shields.io/badge/notice-copyright-yellow.svg)](NOTICE) [![Apache V2 License](https://img.shields.io/badge/license-Apache%20V2-orange.svg)](LICENSE) [![TF Registry](https://img.shields.io/badge/terraform-registry-blue.svg)](https://registry.terraform.io/modules/claranet/alerting/azurerm/)

Azure module to create some [Azure Monitor Alerts](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/alerts-overview)
with an [Action Group](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/action-groups) for notifications destination.
This module handles alerts of type:
  - [Activity Log alerts](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/alerts-activity-log)

<!-- BEGIN_TF_DOCS -->
## Global versioning rule for Claranet Azure modules

| Module version | Terraform version | AzureRM version |
| -------------- | ----------------- | --------------- |
| >= 7.x.x       | 1.3.x             | >= 3.0          |
| >= 6.x.x       | 1.x               | >= 3.0          |
| >= 5.x.x       | 0.15.x            | >= 2.0          |
| >= 4.x.x       | 0.13.x / 0.14.x   | >= 2.0          |
| >= 3.x.x       | 0.12.x            | >= 2.0          |
| >= 2.x.x       | 0.12.x            | < 2.0           |
| <  2.x.x       | 0.11.x            | < 2.0           |

## Contributing

If you want to contribute to this repository, feel free to use our [pre-commit](https://pre-commit.com/) git hook configuration
which will help you automatically update and format some files for you by enforcing our Terraform code module best-practices.

More details are available in the [CONTRIBUTING.md](./CONTRIBUTING.md#pull-request-process) file.

## Usage

This module is optimized to work with the [Claranet terraform-wrapper](https://github.com/claranet/terraform-wrapper) tool
which set some terraform variables in the environment needed by this module.
More details about variables set by the `terraform-wrapper` available in the [documentation](https://github.com/claranet/terraform-wrapper#environment).

```hcl
module "azure_region" {
  source  = "claranet/regions/azurerm"
  version = "x.x.x"

  azure_region = var.azure_region
}

module "rg" {
  source  = "claranet/rg/azurerm"
  version = "x.x.x"

  location    = module.azure_region.location
  client_name = var.client_name
  environment = var.environment
  stack       = var.stack
}

module "alerting" {
  source  = "claranet/alerting/azurerm"
  version = "x.x.x"

  location_short = module.azure_region.location_short
  client_name    = var.client_name
  environment    = var.environment
  stack          = var.stack

  resource_group_name     = module.rg.resource_group_name
  action_group_short_name = "Alerting"

  action_group_webhooks = {
    PagerDuty = "https://events.pagerduty.com/integration/{integration-UID}/enqueue"
    Slack     = "https://hooks.slack.com/services/{azerty}/XXXXXXXXXXXXXXx/{hook-key}"
  }

  activity_log_alerts = {
    "service-health" = {
      description         = "ServiceHealth global Subscription alerts"
      resource_group_name = module.rg.resource_group_name
      scopes              = [format("/subscriptions/%s", var.azure_subscription_id)]
      criteria = {
        category = "ServiceHealth"
      }
    }

    "security-center" = {
      custom_name         = "${var.stack}-global-security-center"
      description         = "Security Center global Subscription alerts"
      resource_group_name = module.rg.resource_group_name
      scopes              = [format("/subscriptions/%s", var.azure_subscription_id)]
      criteria = {
        category = "Security"
        level    = "Error"
      }
    }

    "advisor" = {
      custom_name         = "${var.stack}-global-advisor-alerts"
      description         = "Advisor global Subscription alerts"
      resource_group_name = module.rg.resource_group_name
      scopes              = [format("/subscriptions/%s", var.azure_subscription_id)]
      criteria = {
        category = "Recommendation"
        level    = "Informational"
      }
    }

    "managed-disks" = {
      custom_name         = "${var.stack}-global-managed-disks-alerts"
      description         = "Azure disks movements alerts"
      resource_group_name = module.rg.resource_group_name
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
      resource_group_name = module.rg.resource_group_name
      scopes              = [format("/subscriptions/%s/resourceGroups/%s/providers/Microsoft.Compute/virtualMachines/%s", var.azure_subscription_id, module.rg.resource_group_name, "myVM")]
      criteria = [{
        metric_namespace = "Microsoft.Compute/virtualMachines"
        metric_name      = "Percentage CPU"
        aggregation      = "Total"
        operator         = "GreaterThan"
        threshold        = 80
      }]
    }
  }

  extra_tags = {
    purpose = "alerting testing"
  }
}
```

## Providers

| Name | Version |
|------|---------|
| azurecaf | ~> 1.2.28 |
| azurerm | ~> 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_monitor_action_group.action_group_notification](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_action_group) | resource |
| [azurerm_monitor_activity_log_alert.activity_log_alert](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_activity_log_alert) | resource |
| [azurerm_monitor_metric_alert.metric_alert](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert) | resource |
| [azurecaf_name.action_group](https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/data-sources/name) | data source |
| [azurecaf_name.activity_log_alerts](https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/data-sources/name) | data source |
| [azurecaf_name.metric_alerts](https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/data-sources/name) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| action\_group\_emails | Map of Emails to notify. Example: `{ ml-devops = devops@contoso.com }`. | `map(string)` | `{}` | no |
| action\_group\_short\_name | Action Group short name | `string` | n/a | yes |
| action\_group\_webhooks | Map of Webhooks to notify. Example: `{ PagerDuty = 'https://events.pagerduty.com/integration/abcdefgh12345azerty/enqueue' }`. | `map(string)` | `{}` | no |
| activity\_log\_alerts | Map of Activity log Alerts. | <pre>map(object({<br>    description         = optional(string)<br>    custom_name         = optional(string)<br>    resource_group_name = optional(string)<br>    scopes              = list(string)<br>    criteria = object({<br>      operation_name = optional(string)<br>      category       = optional(string, "Recommendation")<br>      level          = optional(string, "Error")<br>      status         = optional(string)<br><br>      resource_provider = optional(string)<br>      resource_type     = optional(string)<br>      resource_group    = optional(string)<br>      resource_id       = optional(string)<br>    })<br>  }))</pre> | `{}` | no |
| client\_name | Client name/account used in naming. | `string` | n/a | yes |
| custom\_action\_group\_name | Optional custom Action Group name | `string` | `null` | no |
| default\_tags\_enabled | Option to enable or disable default tags. | `bool` | `true` | no |
| environment | Project environment. | `string` | n/a | yes |
| extra\_tags | Extra tags to set on each created resource. | `map(string)` | `{}` | no |
| location\_short | Short string for Azure location. | `string` | n/a | yes |
| metric\_alerts | Map of metric Alerts | <pre>map(object({<br>    custom_name              = optional(string, null)<br>    description              = optional(string, null)<br>    resource_group_name      = optional(string)<br>    scopes                   = optional(list(string), [])<br>    enabled                  = optional(bool, true)<br>    auto_mitigate            = optional(bool, true)<br>    severity                 = optional(number, 3)<br>    frequency                = optional(string, "PT5M")<br>    window_size              = optional(string, "PT5M")<br>    target_resource_type     = optional(string, null)<br>    target_resource_location = optional(string, null)<br><br>    tags = optional(map(string), {})<br><br>    criteria = optional(list(object({<br>      metric_namespace       = string<br>      metric_name            = string<br>      aggregation            = string<br>      operator               = string<br>      threshold              = number<br>      skip_metric_validation = optional(bool, false)<br>      dimension = optional(list(object({<br>        name     = string<br>        operator = optional(string, "Include")<br>        values   = list(string)<br>      })), [])<br>    })), [])<br><br>    dynamic_criteria = optional(list(object({<br>      metric_namespace         = string<br>      metric_name              = string<br>      aggregation              = string<br>      operator                 = string<br>      alert_sensitivity        = optional(string, "Medium")<br>      evaluation_total_count   = optional(number, 4)<br>      evaluation_failure_count = optional(number, 4)<br>      ignore_data_before       = optional(string)<br>      skip_metric_validation   = optional(bool, false)<br>      dimension = optional(list(object({<br>        name     = string<br>        operator = optional(string, "Include")<br>        values   = list(string)<br>      })), [])<br>    })), [])<br><br>    application_insights_web_test_location_availability_criteria = optional(object({<br>      web_test_id           = string<br>      component_id          = string<br>      failed_location_count = number<br>    }), null)<br>  }))</pre> | `{}` | no |
| name\_prefix | Optional prefix for the generated name | `string` | `""` | no |
| name\_suffix | Optional suffix for the generated name | `string` | `""` | no |
| resource\_group\_name | Resource group name. | `string` | n/a | yes |
| service\_health | A block supports the following: `events`, `locations` and `services`. https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_activity_log_alert | <pre>object({<br>    events    = optional(list(string), ["Incident"])<br>    locations = optional(list(string), ["Global"])<br>    services  = optional(list(string))<br>  })</pre> | `null` | no |
| stack | Project stack name. | `string` | n/a | yes |
| use\_caf\_naming | Use the Azure CAF naming provider to generate default resource name. `custom_action_group_name` override this if set. Legacy default name is used if this is set to `false`. | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| action\_group\_id | Notification Action Group ID. |
| action\_group\_name | Notification Action Group name. |
| activity\_log\_alerts | Activity log alerts attributes. |
| metric\_alerts | Metric alerts attributes. |
<!-- END_TF_DOCS -->
## Related documentation

Microsoft Azure documentation:
  - [Activity Log alerts](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/alerts-activity-log)
  - [Activity Log view](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/activity-log-view#azure-portal)
  - [Activity Log PagerDuty](https://docs.microsoft.com/en-us/azure/service-health/service-health-alert-webhook-pagerduty)

## Github issues

~~Additional fields for Service Health (Regions and Services): [https://github.com/terraform-providers/terraform-provider-azurerm/issues/2996](https://github.com/terraform-providers/terraform-provider-azurerm/issues/2996)~~

This is fixed now with AzureRM provider `v2.56.0`: [`azurerm_monitor_activity_log_alert` - support for `service_health` (#10978)](https://github.com/terraform-providers/terraform-provider-azurerm/blob/master/CHANGELOG.md#2560-april-15-2021)
