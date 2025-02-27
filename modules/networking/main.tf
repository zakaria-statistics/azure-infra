resource "azurerm_virtual_network" "vnet" {
  name                = "spot-vnet"
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet" {
  name                 = "spot-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "public_ip" {
  name                = "spot-vm-ip"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
}
