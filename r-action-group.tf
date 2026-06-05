moved {
  from = azurerm_monitor_action_group.action_group_notification
  to   = azurerm_monitor_action_group.main
}

resource "azurerm_monitor_action_group" "main" {
  name                = local.name
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

  dynamic "logic_app_receiver" {
    for_each = var.action_group_logic_app_receivers
    content {
      name                    = logic_app_receiver.key
      resource_id             = logic_app_receiver.value.resource_id
      callback_url            = logic_app_receiver.value.callback_url
      use_common_alert_schema = true
    }
  }

  tags = merge(local.default_tags, var.extra_tags)
}
