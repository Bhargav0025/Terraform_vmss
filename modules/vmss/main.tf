resource "azurerm_linux_virtual_machine_scale_set" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.vm_sku
  instances           = var.instance_count
  computer_name_prefix = var.name
  upgrade_mode        = "Manual"
  overprovision       = true

  # 🔐 Add this block
  admin_username = var.admin_username
  admin_password = var.admin_password
  disable_password_authentication = false

  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = "latest"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  network_interface {
    name    = "${var.name}-nic"
    primary = true

    ip_configuration {
      name                                   = "${var.name}-ipconfig"
      subnet_id                              = var.subnet_id
      load_balancer_backend_address_pool_ids = [var.backend_pool_id]
    }
  }

  health_probe_id = var.health_probe_id
}

