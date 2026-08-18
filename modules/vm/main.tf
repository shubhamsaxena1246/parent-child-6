data "azurerm_public_ip" "example" {
  for_each = var.vms

  name                = each.value.pip_name
  resource_group_name = each.value.resource_group_name
}

data "azurerm_subnet" "example" {
  for_each = var.vms

  name                 = each.value.snet_name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}

resource "azurerm_network_interface" "nic" {
  for_each = var.vms

  name                = each.value.nic_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.example[each.key].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = data.azurerm_public_ip.example[each.key].id
  }
}

resource "azurerm_network_security_group" "nsg" {
  for_each = var.vms

  name                = each.value.nsg_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  security_rule {
    name                       = "Allow-SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-HTTP"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface_security_group_association" "nsg_assoc" {
  for_each = var.vms

  network_interface_id      = azurerm_network_interface.nic[each.key].id
  network_security_group_id = azurerm_network_security_group.nsg[each.key].id
}

resource "azurerm_virtual_machine" "main" {
  for_each = var.vms

  name                  = each.value.vm_name
  location              = each.value.location
  resource_group_name   = each.value.resource_group_name
  network_interface_ids = [azurerm_network_interface.nic[each.key].id]
  vm_size               = "Standard_DC1ds_v3"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }

  storage_os_disk {
    name              = "myosdisk${each.key}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "hostname"
    admin_username = each.value.admin_username
    admin_password = each.value.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags = {
    environment = "staging"
  }
}

output "domain_name_label" {
  value = {
    for key, pip in data.azurerm_public_ip.example :
    key => pip.domain_name_label
  }
}

output "public_ip_address" {
  value = {
    for key, pip in data.azurerm_public_ip.example :
    key => pip.ip_address
  }
}

output "subnet_id" {
  value = {
    for key, subnet in data.azurerm_subnet.example :
    key => subnet.id
  }
}

output "vm_public_ip" {
  value = {
    for key, pip in data.azurerm_public_ip.example :
    key => pip.ip_address
  }
}