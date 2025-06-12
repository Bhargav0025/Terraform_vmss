variable "name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "load_balancer_ip" {
  type = string
}

variable "vm_port" {
  type    = string
  default = "80"
}
