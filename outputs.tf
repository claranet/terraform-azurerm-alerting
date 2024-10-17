output "resource" {
  description = "Notification Action Group resource object."
  value       = azurerm_monitor_action_group.main
}

output "id" {
  description = "Notification Action Group ID."
  value       = azurerm_monitor_action_group.main.id
}

output "name" {
  description = "Notification Action Group name."
  value       = azurerm_monitor_action_group.main.name
}

output "resource_activity_log_alerts" {
  description = "Activity log alerts resource objects."
  value       = azurerm_monitor_activity_log_alert.main
}

output "resource_metric_alerts" {
  description = "Metric alerts resource objects."
  value       = azurerm_monitor_metric_alert.main
}
