ariable "resource_group_name" {
  type    = string
  default = "terraformvmss-rg"
}

variable "location" {
  type    = string
  default = "eastus"
}

variable "vnet_name" {
  type    = string
  default = "terraformvmss-vnet"
}

variable "vnet_address_space" {
  type    = list(string)
  default = ["10.0.0.0/16"]
}

variable "subnets" {
  type = map(string)
  default = {
    subnet1 = "10.0.1.0/24"
    subnet2 = "10.0.2.0/24"
  }
}

variable "lb_name" {
  type    = string
  default = "terraformvmss-lb"
}

variable "nsg_name" {
  type    = string
  default = "terraformvmss-nsg"
}

variable "vmss_name" {
  type    = string
  default = "terraformvmss-vmss"
}

variable "admin_username" {
  type    = string
  default = "Terraformvmss"
}

variable "admin_password" {
  type      = string
  sensitive = true
  default   = "Bhargav@0025" # change for production
}
