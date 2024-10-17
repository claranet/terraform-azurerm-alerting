data "azurecaf_name" "action_group" {
  name          = var.stack
  resource_type = "azurerm_monitor_action_group"
  prefixes      = var.name_prefix == "" ? null : [local.name_prefix]
  suffixes      = compact([var.client_name, var.location_short, var.environment, local.name_suffix])
  use_slug      = true
  clean_input   = true
  separator     = "-"
}

# Custom naming until managed by CAF provider
data "azurecaf_name" "activity_log_alerts" {
  for_each = var.activity_log_alerts

  name          = var.stack
  resource_type = "azurerm_resource_group"
  prefixes      = compact([local.name_prefix, "mal"])
  suffixes      = compact([var.client_name, var.location_short, var.environment, local.name_suffix, each.key])
  use_slug      = false
  clean_input   = true
  separator     = "-"
}

# Custom naming until managed by CAF provider
data "azurecaf_name" "metric_alerts" {
  for_each = var.metric_alerts

  name          = var.stack
  resource_type = "azurerm_resource_group"
  prefixes      = compact([local.name_prefix, "mma"])
  suffixes      = compact([var.client_name, var.location_short, var.environment, local.name_suffix, each.key])
  use_slug      = false
  clean_input   = true
  separator     = "-"
}
