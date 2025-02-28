output "vm_id" {
  value = module.compute.vm_id
}

output "vm_public_ip" {
  value = module.networking.public_ip_address
}

output "ssh_command" {
  value = "ssh -i ~/.ssh/my_key ${var.admin_username}@${module.networking.public_ip_address}"
}
