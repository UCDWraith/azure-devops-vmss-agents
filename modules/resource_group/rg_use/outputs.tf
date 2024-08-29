output "resource_group_name" {
  value = data.azurerm_resource_group.myresourcegroup.name
}

output "resource_group_location" {
  value = data.azurerm_resource_group.myresourcegroup.location
}
output "resource_group_id" {
  value = data.azurerm_resource_group.myresourcegroup.id
}