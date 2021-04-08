#########################
## Windows VM - Output ##
#########################

# Windows VM ID
output "vm_id" {
  value = azurerm_windows_virtual_machine.windows-vm.id
}

# Windows VM Username
output "vm_username" {
  value = var.windows-admin-username
}

# Windows VM Password
output "vm_password" {
  value = var.windows-admin-password
}

# Windows VM Public IP
output "vm_public_ip" {
  value = azurerm_public_ip.windows-vm-ip.ip_address
}