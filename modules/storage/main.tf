resource "azurerm_managed_disk" "data_disk" {
  name                 = "vm-data-disk"
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = "StandardSSD_LRS"
  create_option        = "Empty"
  disk_size_gb         = 128
}

resource "azurerm_virtual_machine_scale_set_data_disk_attachment" "attach_data_disk" {
  managed_disk_id    = azurerm_managed_disk.data_disk.id
  virtual_machine_id = var.vmss_id
  lun                = 0
  caching            = "ReadWrite"
}
