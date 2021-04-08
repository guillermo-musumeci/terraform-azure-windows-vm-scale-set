##############################
## Core Network - Variables ##
##############################

variable "network-vnet-cidr" {
  type        = string
  description = "The CIDR of the network VNET"
}

variable "vm-subnet-cidr" {
  type        = string
  description = "The CIDR for the vm subnet"
}
