resource "azurerm_network_interface" "test" {
  name                = "${var.application_type}-${var.resource_type}"
  location            = var.location
  resource_group_name = var.resource_group

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.public_ip_address_id
  }
}

resource "azurerm_linux_virtual_machine" "test" {
  name                = "${var.application_type}-${var.resource_type}"
  location            = var.location
  resource_group_name = var.resource_group
  size                = "Standard_DS2_v2"
  admin_username      = var.vm_admin_username
  network_interface_ids = [azurerm_network_interface.test.id]
  admin_ssh_key {
    username   = var.vm_admin_username
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDBsU/vDAulhsxQVn6BnUip0RY1xXgc0M3+icl47Wu31o9U+dSitPfCk9quqiLuFY6ouHPJanp04u3C3gWoldUeMG2Q66Y436gXAlD8s/jq5OY/cfQtaCFK+DUvEZqlOQO6fq8QieS2YU8tMIxiPHWf6vGwMJNxzjs2pOk1NaP0aGTPb0I22V5Tu+/m+qCCVoBFjPLDQhzPPmn+2zlhJWTMrz2oaEwFwmnRDaNPjqHqqrzOGOndx+k9a0680mW9Dx+Zvgc37Y1b9mNgbDYzztMXWs1+8HGB/QQxAULQ2/efixx4PtHr+39whOpVWnHpbxCxLFSS8lKrCYmLE8Qk0cR/+V8jtg414wME8mCUDEQN7NYMywG6iFkd48VCbf7kOncutHwG3UELe7KKCbCPMRsgZfGxo7t8fUFtjxcxtnrdTFVut7yBP4m2mvQlZ5P7IpKGnht+WQPURozn9bP4Trd56GpIBj3Y2BTxhRtLxT/MYulFzziWppSagC0ooCYl1Zc= alvar@LAPTOP-JU9DOLHH"
  }
  os_disk {
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
