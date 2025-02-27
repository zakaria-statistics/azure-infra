output "vm_public_ip" {
  value = azurerm_public_ip.public_ip.ip_address
}

output "ssh_command" {
  value = "ssh -i /home/username/.ssh/my_azure_key ${var.admin_username}@${azurerm_public_ip.public_ip.ip_address}"
}
