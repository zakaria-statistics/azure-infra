variable "resource_group_name" {}
variable "location" {}
variable "vmss_name" {}  # Changed vm_name to vmss_name for scale set
variable "vmss_size" {}  # Changed vm_size to vmss_size for scale set size

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
variable "nsg_id" {}

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

variable "upgrade_policy_mode" {
  description = "The upgrade policy mode for the VMSS"
  type        = string
  default     = "Manual"  # Change based on your desired upgrade policy (e.g., Automatic)
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
