resource "azurecaf_name" "action_group" {
  name          = var.stack
  resource_type = "azurerm_monitor_action_group"
  prefixes      = var.name_prefix == "" ? null : [local.name_prefix]
  suffixes      = compact([var.client_name, var.location_short, var.environment, local.name_suffix, var.use_caf_naming ? "" : "action_group"])
  use_slug      = var.use_caf_naming
  clean_input   = true
  separator     = "-"
}
