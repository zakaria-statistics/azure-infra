variable "resource_group_name" {}
variable "location" {}
variable "vm_name" {}
variable "vm_size" {}

variable "os_disk" {
  type = object({
    caching              = string
    storage_account_type = string
    disk_size_gb         = number
  })
}

variable "admin_username" {}
variable "ssh_public_key" {}
variable "subnet_id" {}
variable "public_ip_id" {}

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