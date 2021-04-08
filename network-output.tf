######################
## Network - Output ##
######################

output "network_rg" {
  value = azurerm_resource_group.network-rg
}

output "network_vnet" {
  value = azurerm_virtual_network.network-vnet
}

output "network_vm_subnet" {
  value = azurerm_subnet.vm-subnet
}

