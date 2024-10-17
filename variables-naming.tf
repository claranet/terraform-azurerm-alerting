# Generic naming variables
variable "name_prefix" {
  description = "Optional prefix for the generated name."
  type        = string
  default     = ""
}

variable "name_suffix" {
  description = "Optional suffix for the generated name."
  type        = string
  default     = ""
}

# Custom naming override
variable "action_group_short_name" {
  description = "Action Group short name."
  type        = string
}

variable "custom_name" {
  description = "Optional custom Action Group name."
  type        = string
  default     = null
}
