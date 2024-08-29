# Generate the SSh key pair for the virtual machine scale set
resource "tls_private_key" "vmss_ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

# Create the linux virtual machine scale set
resource "azurerm_linux_virtual_machine_scale_set" "vmssagentspool" {
  name                        = var.name
  resource_group_name         = var.resource_group_name
  location                    = var.location
  sku                         = var.sku
  instances                   = var.instances
  admin_username              = var.admin_username
  computer_name_prefix        = var.computer_name_prefix
  overprovision               = false
  single_placement_group      = false
  upgrade_mode                = "Manual"
  platform_fault_domain_count = 1
  secure_boot_enabled         = true
  vtpm_enabled                = true

  admin_ssh_key {
    username   = var.admin_username
    public_key = tls_private_key.vmss_ssh_key.public_key_openssh
  }

  automatic_instance_repair {
    enabled      = false
    grace_period = "PT30M"
  }

  source_image_reference {
    offer     = "0001-com-ubuntu-server-jammy"
    publisher = "Canonical"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  os_disk {
    caching                          = "ReadWrite"
    disk_encryption_set_id           = null
    disk_size_gb                     = 30
    secure_vm_disk_encryption_set_id = null
    security_encryption_type         = null
    storage_account_type             = "StandardSSD_LRS"
    write_accelerator_enabled        = false
  }

  network_interface {
    dns_servers                   = []
    enable_accelerated_networking = false
    enable_ip_forwarding          = false
    name                          = "${var.computer_name_prefix}-Nic"
    network_security_group_id     = null
    primary                       = true
    ip_configuration {
      application_gateway_backend_address_pool_ids = []
      application_security_group_ids               = []
      load_balancer_backend_address_pool_ids       = []
      load_balancer_inbound_nat_rules_ids          = []
      name                                         = "${var.computer_name_prefix}-IPConfig"
      primary                                      = false
      subnet_id                                    = var.subnet_id
      version                                      = "IPv4"
    }
  }

  tags = merge({ "ResourceType" = "virtual-machine-scale-set(linux)", "Description" = "Virtual Machine Scale Set running Ubuntu Linux for Azure DevOps self-hosted agent pool." }, var.tags)
}