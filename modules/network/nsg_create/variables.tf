variable "name" {
  type        = string
  description = "The name of the VNET to which the NSG will be associated."
}

variable "location" {
  type        = string
  description = "The location in which the NSG will be created."
}

variable "resource_group_name" {
  type        = string
  description = "The resource_group_name that the NSG will be created in."
}

variable "subnet_id" {
  type        = string
  description = "The subnet_id to which the NSG will be associated."
}

variable "tags" {
  type        = map(string)
  description = "(Optional) A mapping of tags which should be assigned to this Virtual Machine Scale Set."
  default     = {}
}

locals {
  nsg_rule_files = fileset("${path.module}/lib/nsg_rules/", "*.json")
  nsg_rules      = { for file in local.nsg_rule_files : file => jsondecode(file("${path.module}/lib/nsg_rules/${file}")) }
  flat_nsg_rules = merge(
    [
      for ruleset in local.nsg_rules :
      {
        for rule in ruleset.security_rules : "${ruleset.ruleset}-${rule.name}" => rule
      }
  ]...)
}


