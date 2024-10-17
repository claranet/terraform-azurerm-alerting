moved {
  from = azurerm_monitor_activity_log_alert.activity_log_alert
  to   = azurerm_monitor_activity_log_alert.main
}

resource "azurerm_monitor_activity_log_alert" "main" {
  for_each = var.activity_log_alerts

  name        = coalesce(each.value.custom_name, data.azurecaf_name.activity_log_alerts[each.key].result)
  description = each.value.description

  location            = var.monitor_location
  resource_group_name = coalesce(each.value.resource_group_name, var.resource_group_name)
  scopes              = each.value.scopes

  criteria {
    operation_name = each.value.criteria.operation_name
    category       = each.value.criteria.category
    level          = each.value.criteria.level
    status         = each.value.criteria.status

    resource_provider = each.value.criteria.resource_provider
    resource_type     = each.value.criteria.resource_type
    resource_group    = each.value.criteria.resource_group
    resource_id       = each.value.criteria.resource_id

    dynamic "service_health" {
      for_each = var.service_health[*]
      content {
        events    = var.service_health.events
        locations = var.service_health.locations
        services  = var.service_health.services
      }
    }
  }

  action {
    action_group_id = azurerm_monitor_action_group.main.id

    webhook_properties = {
      from = "terraform"
    }
  }

  tags = merge(local.default_tags, var.extra_tags)
}
