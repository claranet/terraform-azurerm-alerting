locals {
  name_prefix  = lower(var.name_prefix != "" ? replace(var.name_prefix, "/[a-z0-9]$/", "$0-") : "")
  default_name = "${local.name_prefix}${var.stack}-${var.client_name}-${var.location_short}-${var.environment}"

  default_tags = {
    env   = var.environment
    stack = var.stack
  }
}
