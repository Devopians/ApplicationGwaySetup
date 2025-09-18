variable "vm_names" {
  description = "Map of VM names and descriptions or roles"
  type        = map(string)
  default = {
    vm1 = "vm1-nginx"
    vm2 = "vm2-starbucks"
  }
}

variable "rg_name" {
  type    = string
  default = "applicationGway-rg-veer"
}

variable "rg_location" {
  type    = string
  default = "eastasia"
}

variable "vnet_name" {
  type    = string
  default = "vnet-apg-veer"
}

variable "vm_subnets" {
  type = map(string)
  default = {
    "apGway" = "10.254.1.0/24"
    "vm1"    = "10.254.2.0/24"
    "vm2"    = "10.254.3.0/24"
  }
}
