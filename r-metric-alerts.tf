resource "azurerm_monitor_metric_alert" "metric_alert" {
  for_each = var.metric_alerts

  name        = coalesce(each.value.custom_name, data.azurecaf_name.metric_alerts[each.key].result)
  description = each.value.description

  resource_group_name = coalesce(each.value.resource_group_name, var.resource_group_name)
  scopes              = each.value.scopes

  enabled       = each.value.enabled
  auto_mitigate = each.value.auto_mitigate
  severity      = each.value.severity

  frequency   = each.value.frequency
  window_size = each.value.window_size

  target_resource_type     = each.value.target_resource_type
  target_resource_location = each.value.target_resource_location

  dynamic "criteria" {
    for_each = each.value.criteria

    content {
      metric_namespace = criteria.value.metric_namespace
      metric_name      = criteria.value.metric_name

      aggregation = criteria.value.aggregation
      operator    = criteria.value.operator
      threshold   = criteria.value.threshold

      skip_metric_validation = criteria.value.skip_metric_validation

      dynamic "dimension" {
        for_each = { for d in criteria.value.dimension : d.name => d }
        content {
          name     = dimension.value.name
          operator = dimension.value.operator
          values   = dimension.value.values
        }
      }
    }
  }

  dynamic "dynamic_criteria" {
    for_each = each.value.dynamic_criteria
    content {
      metric_namespace = dynamic_criteria.value.metric_namespace
      metric_name      = dynamic_criteria.value.metric_name

      aggregation = dynamic_criteria.value.aggregation
      operator    = dynamic_criteria.value.operator

      alert_sensitivity        = dynamic_criteria.value.alert_sensitivity
      evaluation_total_count   = dynamic_criteria.value.evaluation_total_count
      evaluation_failure_count = dynamic_criteria.value.evaluation_failure_count
      ignore_data_before       = dynamic_criteria.value.ignore_data_before

      skip_metric_validation = dynamic_criteria.value.skip_metric_validation

      dynamic "dimension" {
        for_each = dynamic_criteria.value.dimension
        content {
          name     = dimension.value.name
          operator = dimension.value.operator
          values   = dimension.value.values
        }
      }
    }
  }

  dynamic "application_insights_web_test_location_availability_criteria" {
    for_each = toset(
      each.value.application_insights_web_test_location_availability_criteria != null
      ? ["enabled"] : []
    )

    content {
      web_test_id           = each.value.application_insights_web_test_location_availability_criteria.web_test_id
      component_id          = each.value.application_insights_web_test_location_availability_criteria.component_id
      failed_location_count = each.value.application_insights_web_test_location_availability_criteria.failed_location_count
    }
  }

  action {
    action_group_id = azurerm_monitor_action_group.action_group_notification.id

    webhook_properties = {
      from = "terraform"
    }
  }

  tags = merge(local.default_tags, var.extra_tags, each.value.tags)
}
