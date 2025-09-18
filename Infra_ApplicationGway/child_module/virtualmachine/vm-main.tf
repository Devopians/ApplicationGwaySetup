resource "azurerm_network_interface" "nics" {
  for_each            = var.vm_names
  name                = each.key
  resource_group_name = var.rg_name
  location            = var.rg_location


  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.existing_subnet[each.key].id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "vms" {
  for_each                        = var.vm_names
  name                            = each.key
  resource_group_name             = var.rg_name
  location                        = var.rg_location
  size                            = "Standard_F2"
  admin_username                  = "adminuser"
  admin_password                  = "adminuser@6744"
  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.nics[each.key].id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  custom_data = base64encode(<<-EOF
    #!/bin/bash
    set -e
    apt-get update -y
    apt-get upgrade -y
    apt-get install -y nginx
    systemctl enable nginx
    systemctl restart nginx
  EOF
  )
}
