provider "azurerm" {
  features {}
}

module "networking" {
  source              = "./modules/networking"
  resource_group_name = var.resource_group_name
  location            = var.location
  subnet_id = module.networking.subnet_id
  public_ip_id = module.networking.public_ip_id
}

module "compute" {
  source              = "./modules/compute"
  resource_group_name = var.resource_group_name
  location            = var.location
  vmss_name           = var.vmss_name  # Changed to VMSS name
  vmss_size           = var.vmss_size  # Changed to VMSS size
  admin_username      = var.admin_username
  ssh_public_key      = var.ssh_public_key
  public_ip_id        = module.networking.public_ip_id
  subnet_id           = module.networking.subnet_id
  os_disk             = var.os_disk
  image_reference     = var.image_reference
  vmss_capacity       = var.vmss_capacity  # New variable for VMSS capacity
  priority            = var.priority      # New variable for Spot priority
  eviction_policy     = var.eviction_policy # New variable for eviction policy
}

module "storage" {
  source              = "./modules/storage"
  resource_group_name = var.resource_group_name
  location            = var.location
  vmss_id             = module.compute.vmss_id
}

output "vmss_public_ip" {
  value = module.networking.public_ip_address
}

output "ssh_command" {
  value = "ssh -i ~/.ssh/my_key ${var.admin_username}@${module.networking.public_ip_address}"
}
