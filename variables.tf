variable "resource_group_name" {
  type        = string
  description = "The name of the resource group for the Virtual Machine Scale Set"
}

variable "location" {
  type        = string
  description = "(Required) The location/region where the virtual network is created. Changing this forces a new resource to be created."
}

variable "vnet_name" {
  type        = string
  description = "(Required) The name of the virtual network. Changing this forces a new resource to be created."
}

variable "address_space" {
  type        = list(string)
  description = "(Required) The address space that is used the virtual network. You can supply more than one address space."
}

variable "vmss_subnet_name" {
  type        = string
  description = "(Required) The name of the subnet. Changing this forces a new resource to be created."
}

variable "storage_subnet_name" {
  type        = string
  description = "(Required) The name of the subnet. Changing this forces a new resource to be created. Comment out this variable definition if you will not create the storage subnet."
}

variable "vmss_subnet" {
  type        = list(string)
  description = "(Required) The address prefixes to use for the subnet."
}

variable "storage_subnet" {
  type        = list(string)
  description = "(Required) The address prefixes to use for the subnet."
}

variable "vmss_name" {
  type        = string
  description = "(Required) The name of the Linux Virtual Machine Scale Set. Changing this forces a new resource to be created."
}

variable "admin_username" {
  type        = string
  description = "(Required) The username of the local administrator on each Virtual Machine Scale Set instance. Changing this forces a new resource to be created."
}

variable "sku" {
  type        = string
  description = "(Required) The Virtual Machine SKU for the Scale Set, such as Standard_F2."
}

variable "computer_name_prefix" {
  type        = string
  description = "(Optional) The prefix which should be used for the name of the Virtual Machines in this Scale Set. If unspecified this defaults to the value for the name field. If the value of the name field is not a valid computer_name_prefix, then you must specify computer_name_prefix. Changing this forces a new resource to be created."
}

variable "instances" {
  type        = number
  description = "(Optional) The number of Virtual Machines in the Scale Set. Defaults to 0."
  default     = 0
}

variable "tags" {
  type        = map(string)
  description = "(Optional) A mapping of tags which should be assigned to this Virtual Machine Scale Set."
  default     = {}
}