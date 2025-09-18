module "vms" {
  depends_on  = [module.apg]
  source      = "../child_module/virtualmachine"
  rg_name     = var.rg_name
  rg_location = var.rg_location
  vnet_name   = var.vnet_name
  vm_names = {
    "vm1" = "vm1-nginx"
    "vm2" = "vm2-starbucks"
  }
  vm_subnets = {
    "apGway" = "10.254.1.0/24"
    "vm1"    = "10.254.2.0/24"
    "vm2"    = "10.254.3.0/24"
  }
}
module "apg" {
  source      = "../child_module/applicationGway"
  rg_name     = var.rg_name
  rg_location = var.rg_location
  vnet_name   = var.vnet_name
  vm_subnets = {
    "apGway" = "10.254.1.0/24"
    "vm1"    = "10.254.2.0/24"
    "vm2"    = "10.254.3.0/24"
  }
}
