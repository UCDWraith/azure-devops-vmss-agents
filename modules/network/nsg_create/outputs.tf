output "nsg_id" {
  value = azurerm_network_security_group.mgmt_nsg.id
}

output "nsg_location" {
  value = azurerm_network_security_group.mgmt_nsg.location
}

output "nsg_name" {
  value = azurerm_network_security_group.mgmt_nsg.name
}

output "nsg_resource_group_name" {
  value = azurerm_network_security_group.mgmt_nsg.resource_group_name
}

output "nsg_security_rule" {
  value = azurerm_network_security_group.mgmt_nsg.security_rule
}