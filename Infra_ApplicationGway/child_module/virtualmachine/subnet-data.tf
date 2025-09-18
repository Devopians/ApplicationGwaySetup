data "azurerm_subnet" "existing_subnet" {
  for_each             = var.vm_subnets
  name                 = "subnet-${each.key}"
  resource_group_name  = var.rg_name
  virtual_network_name = var.vnet_name
}

output "vm1_subnet_id" {
  value = data.azurerm_subnet.existing_subnet["vm1"]
}
output "vm2_subnet_id" {
  value = data.azurerm_subnet.existing_subnet["vm2"]
}
