####################
# Common Variables #
####################
company     = "kopicloud"
prefix      = "kopi"
environment = "dev"
location    = "northeurope"
description = "Deploy a Windows VM Scale Set"
owner       = "Guillermo Musumeci"
app_name    = "IaaS"

###########
# Network #
###########
network-vnet-cidr = "10.10.0.0/16"
vm-subnet-cidr    = "10.10.1.0/24"

##############
# Windows VM #
##############
windows-vm-hostname    = "tfwinsrv" // Limited to 15 characters
windows-vm-size        = "Standard_B2s"
windows-vm-counter     = 2
windows-admin-username = "tfadmin"
windows-admin-password = "S3cr3ts24"

##################
# Authentication #
##################
azure-subscription-id = "complete-this"
azure-client-id       = "complete-this"
azure-client-secret   = "complete-this"
azure-tenant-id       = "complete-this"
