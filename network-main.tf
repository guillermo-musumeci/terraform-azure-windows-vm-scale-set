####################
## Network - Main ##
####################

# Create a resource group for network
resource "azurerm_resource_group" "network-rg" {
  name     = "${var.prefix}-${var.environment}-network-rg"
  location = var.location
  tags = {
    environment = var.environment
  }
}

# Create the network VNET
resource "azurerm_virtual_network" "network-vnet" {
  name                = "${var.prefix}-${var.environment}-network-vnet"
  address_space       = [var.network-vnet-cidr]
  resource_group_name = azurerm_resource_group.network-rg.name
  location            = azurerm_resource_group.network-rg.location
  tags = {
    environment = var.environment
  }
}

# Create a subnet for VM
resource "azurerm_subnet" "vm-subnet" {
  name                 = "${var.prefix}-${var.environment}-vm-subnet"
  address_prefixes     = [var.vm-subnet-cidr]
  virtual_network_name = azurerm_virtual_network.network-vnet.name
  resource_group_name  = azurerm_resource_group.network-rg.name
}

