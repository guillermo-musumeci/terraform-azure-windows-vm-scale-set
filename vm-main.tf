#######################
## Windows VM - Main ##
#######################

# Get a Static Public IP
resource "azurerm_public_ip" "windows-vm-ip" {
  name                = "${var.windows-vm-hostname}-ip"
  location            = azurerm_resource_group.network-rg.location
  resource_group_name = azurerm_resource_group.network-rg.name
  allocation_method   = "Static"
  
  tags = { 
    application = var.app_name
    environment = var.environment 
  }
}

# Create Network Card for VM
resource "azurerm_network_interface" "windows-vm-nic" {
  name                      = "${var.windows-vm-hostname}-nic"
  location                  = azurerm_resource_group.network-rg.location
  resource_group_name       = azurerm_resource_group.network-rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.vm-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.windows-vm-ip.id
  }

  tags = { 
    application = var.app_name
    environment = var.environment 
  }
}

# Create Windows Virtual Machine
resource "azurerm_windows_virtual_machine" "windows-vm" {
  name                  = var.windows-vm-hostname
  location              = azurerm_resource_group.network-rg.location
  resource_group_name   = azurerm_resource_group.network-rg.name
  size                  = var.windows-vm-size
  network_interface_ids = [azurerm_network_interface.windows-vm-nic.id]
  
  computer_name         = var.windows-vm-hostname
  admin_username        = var.windows-admin-username
  admin_password        = var.windows-admin-password

  os_disk {
    name                 = "${var.windows-vm-hostname}-os-disk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = var.windows-2019-sku
    version   = "latest"
  }

  enable_automatic_updates = true
  provision_vm_agent       = true

  tags = {
    application = var.app_name
    environment = var.environment 
  }
}
