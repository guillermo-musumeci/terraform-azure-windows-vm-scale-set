###################################
## Windows VM Scale Set - Output ##
###################################

# Windows VM ID
# output "web_scale_set" {
#   value = azurerm_virtual_machine_scale_set.web-ss
# }

# Windows VM Username
output "web_scale_username" {
  value = var.windows-admin-username
}

# Windows VM Password
output "web_scale_password" {
  value = var.windows-admin-password
}

