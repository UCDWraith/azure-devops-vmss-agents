resource "azurerm_resource_group" "myresourcegroup" {
  name     = var.name
  location = var.location

  tags = merge({ "ResourceType" = format("%s", "azure-resource-group") }, var.tags)
}