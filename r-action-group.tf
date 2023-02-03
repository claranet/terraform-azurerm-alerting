resource "azurerm_monitor_action_group" "action_group_notification" {
  name                = local.action_group_name
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
