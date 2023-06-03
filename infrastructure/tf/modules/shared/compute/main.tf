locals {
  env_config          = var.env_config
  compute_credentials = var.compute_credentials
  subnet_config       = var.subnet_config
  web_host_name       = "web-host-${local.env_config.env}"
  app_host_name       = "app-host-${local.env_config.env}"
}
resource "azurerm_availability_set" "web_availabilty_set" {
  name                = "web_availabilty_set"
  location            = local.env_config.location
  resource_group_name = local.env_config.resource_group
}

resource "azurerm_network_interface" "web-net-interface" {
  name                = "web-network"
  resource_group_name = local.env_config.resource_group
  location            = local.env_config.location

  ip_configuration {
    name                          = "web-webserver"
    subnet_id                     = local.subnet_config.web_subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "web-vm" {
  name                          = "web-vm-${local.env_config.env}"
  location                      = local.env_config.location
  resource_group_name           = local.env_config.resource_group
  network_interface_ids         = [azurerm_network_interface.web-net-interface.id]
  availability_set_id           = azurerm_availability_set.web_availabilty_set.id
  vm_size                       = "Standard_D2s_v3"
  delete_os_disk_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "web-disk-${local.env_config.env}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = local.web_host_name
    admin_username = local.compute_credentials.admin_username
    admin_password = local.compute_credentials.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}


resource "azurerm_availability_set" "app_availabilty_set" {
  name                = "app_availabilty_set"
  location            = local.env_config.location
  resource_group_name = local.env_config.resource_group
}

resource "azurerm_network_interface" "app-net-interface" {
  name                = "app-network-${local.env_config.env}"
  resource_group_name = local.env_config.resource_group
  location            = local.env_config.location

  ip_configuration {
    name                          = "app-webserver-${local.env_config.env}"
    subnet_id                     = local.subnet_config.app_subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "app-vm" {
  name                          = "app-vm-${local.env_config.env}"
  location                      = local.env_config.location
  resource_group_name           = local.env_config.resource_group
  network_interface_ids         = [azurerm_network_interface.app-net-interface.id]
  availability_set_id           = azurerm_availability_set.app_availabilty_set.id
  vm_size                       = "Standard_D2s_v3"
  delete_os_disk_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "app-disk-${local.env_config.env}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = local.app_host_name
    admin_username = local.compute_credentials.admin_username
    admin_password = local.compute_credentials.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}
