# Terraform Azure Windows Virtual Machine

Deploy a Windows Virtual Machine in Azure using Terraform

Update the **sku** on this section of the **windows-vm-main.tf** file, to configure the version of Windows Server.

```
source_image_reference {
  publisher = "MicrosoftWindowsServer"
  offer     = "WindowsServer"
  sku       = var.windows-2019-sku
  version   = "latest"
}
```

OS variables are located on the file **windows-vm-variables.tf**

```
# Windows Server 2019 SKU used to build VMs
variable "windows-2019-sku" {
  type        = string
  description = "Windows Server 2019 SKU used to build VMs"
  default     = "2019-Datacenter"
}

# Windows Server 2016 SKU used to build VMs
variable "windows-2016-sku" {
  type        = string
  description = "Windows Server 2016 SKU used to build VMs"
  default     = "2016-Datacenter"
}

# Windows Server 2012 R2 SKU used to build VMs
variable "windows-2012-sku" {
  type        = string
  description = "Windows Server 2012 R2 SKU used to build VMs"
  default     = "2012-R2-Datacenter"
}
```
