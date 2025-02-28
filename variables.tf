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

variable "vm_name" {
  default = "spot-vm"
}

variable "admin_username" {
  default = "azureuser"
}

variable "ssh_public_key" {
  default = "C:/Users/zakar/.ssh/my_key.pub"
}

variable "vm_size" {
  default = "Standard_DC4s_v3" 
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