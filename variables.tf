variable "subscription_id" {}
variable "client_id" {}
variable "client_secret" {}
variable "tenant_id" {}


variable "location" {
  default = "West"
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
  default = "Standard_DC4s_v3"  # 4 CPUs, 16 GiB RAM, 150 GiB ephemeral disk
}

variable "os_disk_size" {
  default = 128  # E10 Disk (128 GiB)
}
