resource "azurerm_network_security_group" "mgmt_nsg" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = merge({ "ResourceType" = format("%s", "network-security-group") }, var.tags)
}

resource "azurerm_network_security_rule" "mgmt_nsg_rules" {
  for_each = local.flat_nsg_rules

  name                        = each.value.name
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_ranges     = try([each.value.destination_port_range], each.value.destination_port_ranges)
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  description                 = each.value.description
  resource_group_name         = azurerm_network_security_group.mgmt_nsg.resource_group_name
  network_security_group_name = azurerm_network_security_group.mgmt_nsg.name
}

resource "azurerm_subnet_network_security_group_association" "Associate_NSG" {
  subnet_id                 = var.subnet_id
  network_security_group_id = azurerm_network_security_group.mgmt_nsg.id
}