variable "subscription_id" {}
variable "client_id" {}
variable "client_secret" {}
variable "tenant_id" {}

variable "location" {
  default = "West US"
}

variable "resource_group_name" {
  default = "spot-vm-rg"
}

variable "vmss_name" {
  default = "spot-vmss"  # Renamed to match VMSS name
}

variable "admin_username" {
  default = "azureuser"
}

variable "ssh_public_key" {
  default = "C:/Users/zakar/.ssh/my_key.pub"
}

variable "vmss_size" {
  default = "Standard_DC4s_v3"  # VM size for scale set
}

variable "os_disk" {
  type = object({
    caching              = string
    storage_account_type = string
    disk_size_gb         = number
  })
  default = {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = 128
  }
}

variable "image_reference" {
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  default = {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "22.04-LTS"
    version   = "2024.0.202108270"
  }
}

variable "vmss_capacity" {
  description = "The initial number of VMs to deploy in the VMSS"
  default     = 1
}

variable "priority" {
  description = "Priority of the VMs in the scale set. For Spot VMs use 'Spot'"
  default     = "Spot"
}

variable "eviction_policy" {
  description = "Eviction policy for Spot VMs. Use 'Delete' to recreate them if evicted."
  default     = "Delete"
}
