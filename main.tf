provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

module "networking" {
  source              = "./modules/networking"
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "compute" {
  source              = "./modules/compute"
  resource_group_name = var.resource_group_name
  location            = var.location
  vm_name             = var.vm_name
  vm_size             = var.vm_size
  admin_username      = var.admin_username
  ssh_public_key      = var.ssh_public_key
  subnet_id           = module.networking.subnet_id
  public_ip_id        = module.networking.public_ip_id
  os_disk             = var.os_disk
  image_reference     = var.image_reference
}

module "storage" {
  source              = "./modules/storage"
  resource_group_name = var.resource_group_name
  location            = var.location
  vm_id               = module.compute.vm_id
}

output "vm_public_ip" {
  value = module.networking.public_ip_address
}

output "ssh_command" {
  value = "ssh -i ~/.ssh/my_key ${var.admin_username}@${module.networking.public_ip_address}"
}
