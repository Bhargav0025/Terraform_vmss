variable "name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "vmss_id" {
  type = string
}

variable "default_instance_count" {
  type    = number
  default = 2
}

variable "min_instance_count" {
  type    = number
  default = 1
}

variable "max_instance_count" {
  type    = number
  default = 3
}

variable "scale_out_threshold" {
  type    = number
  default = 80
}

variable "scale_in_threshold" {
  type    = number
  default = 10
}
