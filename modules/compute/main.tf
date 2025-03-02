resource "azurerm_virtual_machine_scale_set" "vmss" {
  name                = var.vmss_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku {
    name     = var.vmss_size
    tier     = "Standard"
    capacity = var.vmss_capacity
  }
  upgrade_policy_mode = var.upgrade_policy_mode

  # Spot configuration
  priority        = var.priority
  eviction_policy = var.eviction_policy

  os_profile {
    computer_name_prefix = var.vmss_name
    admin_username       = var.admin_username
  }

  storage_profile_os_disk {
    caching       = var.os_disk.caching
    create_option = "FromImage"
  }

  storage_profile_image_reference {
    publisher = var.image_reference.publisher
    offer     = var.image_reference.offer
    sku       = var.image_reference.sku
    version   = var.image_reference.version
  }
  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/${var.admin_username}/.ssh/authorized_keys"
      key_data = file(var.ssh_public_key)
    }
  }

  network_profile {
    name    = "vmss-nic"
    primary = true
    ip_configuration {
      name                          = "vmss-ip-config"
      subnet_id                     = var.subnet_id
      primary = true
    }
  }
}

output "vmss_id" {
  value = azurerm_virtual_machine_scale_set.vmss.id
}
