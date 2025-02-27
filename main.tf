module "networking" {
  source              = "./modules/networking"
  resource_group_name = var.resource_group_name
  location           = var.location
}

module "compute" {
  vm_name = var.vm_name
  source              = "./modules/compute"
  resource_group_name = var.resource_group_name
  location            = var.location
  vm_size             = var.vm_size
  admin_username      = var.admin_username
  ssh_public_key      = var.ssh_public_key
  subnet_id           = module.networking.subnet_id
  public_ip_id        = module.networking.public_ip_id
}

module "storage" {
  source              = "./modules/storage"
  resource_group_name = var.resource_group_name
  location            = var.location
  vm_id               = module.compute.vm_id
}
