resource "azurerm_network_interface" "test" {
  name                = "Ens-Qua-Rel-NIC"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = "${var.subnet_id}"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "${var.publicip}"
  }
}

resource "azurerm_linux_virtual_machine" "test" {
  name                = "Ens-Qua-Rel-VM"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"
  size                = "Standard_B1s"
  admin_username      = "gfalace"
  network_interface_ids = [azurerm_network_interface.test.id]
  
  admin_ssh_key {
    username = "gfalace"
    public_key = "${var.public_key}"
  }

  os_disk {
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}
