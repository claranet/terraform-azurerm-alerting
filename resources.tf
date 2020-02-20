resource "azurerm_monitor_action_group" "action_group_notification" {
  name                = coalesce(var.custom_action_group_name, format("%s-actiongroup", local.default_name))
  resource_group_name = var.resource_group_name
  short_name          = var.action_group_short_name

  dynamic "webhook_receiver" {
    for_each = var.action_group_webhooks

    content {
      name                    = webhook_receiver.key
      service_uri             = webhook_receiver.value
      use_common_alert_schema = true
    }
  }

  dynamic "email_receiver" {
    for_each = var.action_group_emails
    content {
      name                    = email_receiver.key
      email_address           = email_receiver.value
      use_common_alert_schema = true
    }
  }

  tags = merge(local.default_tags, var.extra_tags)
}

resource "azurerm_monitor_activity_log_alert" "activity_log_alert" {
  for_each = var.activity_log_alerts

  name        = lookup(each.value, "custom_name", format("%s-%s-alert", local.default_name, each.key))
  description = each.value.description

  resource_group_name = lookup(each.value, "resource_group_name", var.resource_group_name)
  scopes              = each.value.scopes

  criteria {
    operation_name = lookup(each.value.criteria, "operation_name", null)
    category       = lookup(each.value.criteria, "category", "Recommendation")
    level          = lookup(each.value.criteria, "level", "Error")

    resource_provider = lookup(each.value.criteria, "resource_provider", null)
    resource_type     = lookup(each.value.criteria, "resource_type", null)
    resource_group    = lookup(each.value.criteria, "resource_group", null)
    resource_id       = lookup(each.value.criteria, "resource_id", null)
  }

  action {
    action_group_id = azurerm_monitor_action_group.action_group_notification.id

    webhook_properties = {
      from = "terraform"
    }
  }

  tags = merge(local.default_tags, var.extra_tags)
}
