provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

# Create Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# Upload SSH Public Key to Azure
resource "azurerm_ssh_public_key" "ssh_key" {
  name                = "spot-vm-key"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  public_key          = file(var.ssh_public_key)
}

# Create Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "spot-vnet"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  address_space       = ["10.0.0.0/16"]
}

# Create Subnet
resource "azurerm_subnet" "subnet" {
  name                 = "spot-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Create Public IP
resource "azurerm_public_ip" "public_ip" {
  name                = "spot-vm-ip"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  allocation_method   = "Static"  # Change to Static
  # domain_name_label   = var.domain_name_label  # Add this line
}

# Create Network Interface
resource "azurerm_network_interface" "nic" {
  name                = "spot-vm-nic"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location

  ip_configuration {
    name                          = "spot-ip-config"
    subnet_id                     = azurerm_subnet.subnet.id
    public_ip_address_id          = azurerm_public_ip.public_ip.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Create Spot VM
resource "azurerm_linux_virtual_machine" "spot_vm" {
  name                = var.vm_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  size                = var.vm_size
  admin_username      = var.admin_username
  network_interface_ids = [azurerm_network_interface.nic.id]

  priority       = "Spot"
  eviction_policy = "Delete"
  max_bid_price  = -1  # Use Azure's best price

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
    disk_size_gb         = var.os_disk_size
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "22.04-LTS"
    version   = "22.04.202402210"
  }

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.ssh_public_key)
  }

  tags = {
    Environment = "Dev"
  }
}
