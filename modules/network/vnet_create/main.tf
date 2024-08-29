resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = var.location
  address_space       = var.address_space
  resource_group_name = var.resource_group_name
  tags                = merge({ "ResourceType" = "azure-virtual-network" }, var.tags)
}