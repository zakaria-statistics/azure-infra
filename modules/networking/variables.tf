variable "resource_group_name" {}
variable "location" {}

variable "subnet_id" {}
variable "public_ip_id" {}

variable "vmss_name" {
  description = "Name of the VMSS"
  default     = "spot-vmss"
}

variable "nsg_name" {
  description = "Name of the Network Security Group for the VMSS"
  default     = "spot-vmss-nsg"
}
