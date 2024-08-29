# To create a new resource group
module "vmss_resource_group" {
  source   = "./modules/resource_group/rg_create"
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

# To use an existing resource group
# module "vmss_resource_group" {
#   source              = "./modules/resource_group/rg_use"
#   resource_group_name = var.resource_group_name
# }

module "mgmt_vnet" {
  source              = "./modules/network/vnet_create"
  vnet_name           = var.vnet_name
  location            = module.vmss_resource_group.resource_group_location
  resource_group_name = module.vmss_resource_group.resource_group_name
  address_space       = var.address_space
  tags                = var.tags
}

module "vmss_subnet" {
  source               = "./modules/network/subnet_create"
  virtual_network_name = module.mgmt_vnet.vnet_name
  subnet_name          = var.vmss_subnet_name
  resource_group_name  = module.vmss_resource_group.resource_group_name
  address_prefixes     = var.vmss_subnet
}

module "storage_subnet" {
  source               = "./modules/network/subnet_create"
  virtual_network_name = module.mgmt_vnet.vnet_name
  subnet_name          = var.storage_subnet_name
  resource_group_name  = module.vmss_resource_group.resource_group_name
  address_prefixes     = var.storage_subnet
}

module "mgmt_nsg" {
  source              = "./modules/network/nsg_create"
  resource_group_name = module.vmss_resource_group.resource_group_name
  location            = module.vmss_resource_group.resource_group_location
  name                = format("NSG-%s", module.vmss_subnet.subnet_name)
  subnet_id           = module.vmss_subnet.subnet_id
  tags                = var.tags
}

module "vmss_ado_agents" {
  source               = "./modules/vm_scale_set_linux"
  name                 = var.vmss_name
  location             = module.vmss_resource_group.resource_group_location
  resource_group_name  = module.vmss_resource_group.resource_group_name
  admin_username       = var.admin_username
  sku                  = var.sku
  computer_name_prefix = var.computer_name_prefix
  subnet_id            = module.vmss_subnet.subnet_id
  tags                 = var.tags
}
