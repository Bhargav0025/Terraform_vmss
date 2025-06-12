variable "name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "vm_sku" {
  type    = string
  default = "Standard_DS1_v2"
}

variable "instance_count" {
  type    = number
  default = 2
}

variable "admin_username" {
  type = string
}

variable "admin_password" {
  type      = string
  sensitive = true
}

variable "subnet_id" {
  type = string
}

variable "backend_pool_id" {
  type = string
}

variable "health_probe_id" {
  type = string
}

variable "zone" {
  type    = string
  default = ""
}

variable "image_publisher" {
  type    = string
  default = "Canonical"
}

variable "image_offer" {
  type    = string
  default = "UbuntuServer"
}

variable "image_sku" {
  type    = string
  default = "18.04-LTS"
}
