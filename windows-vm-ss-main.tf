#################################
## Windows VM Scale Set - Main ##
#################################

# Bootstrapping Script
data "template_file" "tf-script" {
  template = file("setup.ps1")
}

# Create Network Security Group to Access VM from Internet
resource "azurerm_network_security_group" "web-nsg" {
  name                = "${var.prefix}-${var.environment}-web-nsg"
  location            = azurerm_resource_group.network-rg.location
  resource_group_name = azurerm_resource_group.network-rg.name

  security_rule {
    name                       = "AllowRDP"
    description                = "Allow RDP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*" 
  }

  tags = {
    application = var.app_name
    environment = var.environment 
  }
}

# Associate the NSG with the Subnet
resource "azurerm_subnet_network_security_group_association" "web-nsg-association" {
  subnet_id                 = azurerm_subnet.vm-subnet.id
  network_security_group_id = azurerm_network_security_group.web-nsg.id
}

# Create Windows Virtual Machine Scale Set
resource "azurerm_windows_virtual_machine_scale_set" "web-ss" {
  name                = "${var.prefix}-${var.environment}-web-ss"
  location            = azurerm_resource_group.network-rg.location
  resource_group_name = azurerm_resource_group.network-rg.name

  sku        = var.windows-vm-size
  instances  = 1

  computer_name_prefix  = var.windows-vm-hostname
  admin_username        = var.windows-admin-username
  admin_password        = var.windows-admin-password

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = var.windows-2019-sku
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  network_interface {
    name    = "${var.windows-vm-hostname}-network"
    primary = true

    ip_configuration {
      name      = "${var.windows-vm-hostname}-internal"
      primary   = true
      subnet_id = azurerm_subnet.vm-subnet.id
    }
  }

  extension {
    name                       = "CustomScript"
    publisher                  = "Microsoft.Compute"
    type                       = "CustomScriptExtension"
    type_handler_version       = "1.10"
    auto_upgrade_minor_version = true

    settings = jsonencode({ "commandToExecute" = "powershell -command \"[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String('${base64encode(data.template_file.tf-script.rendered)}')) | Out-File -filepath setup.ps1\" && powershell -ExecutionPolicy Unrestricted -File setup.ps1" })

    protected_settings = jsonencode({ "managedIdentity" = {} })
  }

  tags = {
    application = var.app_name
    environment = var.environment 
  }
} 
