variable "name" {
  type        = string
  description = "(Required) The name of the Linux Virtual Machine Scale Set. Changing this forces a new resource to be created."
}

variable "location" {
  type        = string
  description = "(Required) The Azure location where the Linux Virtual Machine Scale Set should exist. Changing this forces a new resource to be created."
}

variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the Resource Group in which the Linux Virtual Machine Scale Set should be exist. Changing this forces a new resource to be created."
}

variable "admin_username" {
  type        = string
  description = "(Required) The username of the local administrator on each Virtual Machine Scale Set instance. Changing this forces a new resource to be created."
}

variable "sku" {
  type        = string
  description = "(Required) The Virtual Machine SKU for the Scale Set, such as Standard_F2."
}

variable "instances" {
  type        = number
  description = "(Optional) The number of Virtual Machines in the Scale Set. Defaults to 0."
  default     = 0
}

variable "computer_name_prefix" {
  type        = string
  description = "(Optional) The prefix which should be used for the name of the Virtual Machines in this Scale Set. If unspecified this defaults to the value for the name field. If the value of the name field is not a valid computer_name_prefix, then you must specify computer_name_prefix. Changing this forces a new resource to be created."
}

# variable "public_key" {
#   type        = string
#   description = "(Required) The Public Key which should be used for authentication, which needs to be at least 2048-bit and in ssh-rsa format."
#   sensitive   = true
# }

variable "subnet_id" {
  type        = string
  description = "(Optional) The ID of the Subnet which this IP Configuration should be connected to."
}

variable "tags" {
  type        = map(string)
  description = "(Optional) A mapping of tags which should be assigned to this Virtual Machine Scale Set."
  default     = {}
}