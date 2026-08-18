import {
  to = module.example.azurerm_resource_group.example["rg1"]

  id = "/subscriptions/a60bfb4b-160f-44e7-979b-775bdd787c90/resourceGroups/rg-paratp"
}

import {
  to = module.pip.azurerm_public_ip.pip["pip1"]

  id = "/subscriptions/a60bfb4b-160f-44e7-979b-775bdd787c90/resourceGroups/rg-paratp/providers/Microsoft.Network/publicIPAddresses/pip_vm_1"
}

import {
  to = module.vnet.azurerm_virtual_network.vnet["vnet1"]

  id = "/subscriptions/a60bfb4b-160f-44e7-979b-775bdd787c90/resourceGroups/rg-paratp/providers/Microsoft.Network/virtualNetworks/vnet"
}
import {
  to = module.snet.azurerm_subnet.snet["snet1"]

  id = "/subscriptions/a60bfb4b-160f-44e7-979b-775bdd787c90/resourceGroups/rg-paratp/providers/Microsoft.Network/virtualNetworks/vnet/subnets/subnet_frontend"
}
import {
  to = module.main.azurerm_network_interface.nic["vms1"]

  id = "/subscriptions/a60bfb4b-160f-44e7-979b-775bdd787c90/resourceGroups/rg-paratp/providers/Microsoft.Network/networkInterfaces/nic_1"
}

import {
  to = module.main.azurerm_network_security_group.nsg["vms1"]

  id = "/subscriptions/a60bfb4b-160f-44e7-979b-775bdd787c90/resourceGroups/rg-paratp/providers/Microsoft.Network/networkSecurityGroups/frontend-nsg"
}
import {
  to = module.main.azurerm_network_interface_security_group_association.nsg_assoc["vms1"]

  id = "/subscriptions/a60bfb4b-160f-44e7-979b-775bdd787c90/resourceGroups/rg-paratp/providers/Microsoft.Network/networkInterfaces/nic_1|/subscriptions/a60bfb4b-160f-44e7-979b-775bdd787c90/resourceGroups/rg-paratp/providers/Microsoft.Network/networkSecurityGroups/frontend-nsg"
}