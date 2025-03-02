resource "azurerm_linux_virtual_machine" "spot_vm" {
  name                = var.vmss_name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.vmss_size
  admin_username      = var.admin_username
  network_interface_ids = [azurerm_network_interface.nic.id]

  priority        = "Spot"
  eviction_policy = "Delete"

  source_image_reference {
    publisher = var.image_reference.publisher
    offer     = var.image_reference.offer
    sku       = var.image_reference.sku
    version   = var.image_reference.version
  }

  os_disk {
    caching              = var.os_disk.caching
    storage_account_type = var.os_disk.storage_account_type
    disk_size_gb         = var.os_disk.disk_size_gb
  }

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.ssh_public_key)
  }
}

output "vm_id" {
  value = azurerm_linux_virtual_machine.spot_vm.id
}