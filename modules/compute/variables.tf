variable "resource_group_name" {
    default = "spot-vm-rg"
}
variable "location" {
    default = "East US"
}
variable "vm_size" {
    default = "Standard_D2s_v3"
}

variable "spot-ip-config" {
    default = {
        name      = "spot-ip-config"
        subnet_id = var.subnet_id
        public_ip_address_id = var.public_ip_id
    }
}

variable "os_disk" {
    default = {
        caching              = "ReadWrite"
        storage_account_type = "StandardSSD_LRS"
    }
}
variable "admin_username" {
    default = "azureuser"
}
variable "ssh_public_key" {

}
variable "subnet_id" {
    type = string
}
variable "public_ip_id" {
    type = string
}
