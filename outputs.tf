output "vm_public_ip" {
  value = module.networking.public_ip
}

output "ssh_command" {
  value = "ssh -i ~/.ssh/my_key ${var.admin_username}@${module.networking.public_ip}"
}

output "public_ip_address" {
  value = module.networking.public_ip_address
}

output "vm_id" {
  value = module.compute.vm_id
}
