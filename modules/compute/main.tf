resource "azurerm_network_interface" "nic" {
  name                = "spot-vm-nic"
  resource_group_name = var.resource_group_name
  location            = var.location

  ip_configuration {
    name                          = var.spot-ip-config
    subnet_id                     = var.subnet_id
    public_ip_address_id          = var.public_ip_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "spot_vm" {
  name                = "spot-vm"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.vm_size
  admin_username      = var.admin_username
  network_interface_ids = [azurerm_network_interface.nic.id]

  priority       = "Spot"
  eviction_policy = "Delete"  

  os_disk {
    caching              = var.os_disk["caching"]
    storage_account_type = var.os_disk["storage_account_type"]
    disk_size_gb         = var.os_disk["disk_size_gb"]
  }

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.ssh_public_key)
  }
}
