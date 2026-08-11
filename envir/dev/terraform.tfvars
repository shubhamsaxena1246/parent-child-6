pip = {
  pip1 = {
    pip_name            = "pip_vm_1"
    resource_group_name = "rg-paratp"
    location            = "West US 2"
  }
}
rgs = {
  rg1 = {
    resource_group_name = "rg-paratp"
    location            = "West US 2"
  }
}
snet = {
  snet1 = {
    snet_name            = "subnet_frontend"
    virtual_network_name = "vnet"
    resource_group_name  = "rg-paratp"
    address_prefixes     = ["10.0.0.0/24"]

  }
}
vnet = {
  vnet1 = {
    virtual_network_name = "vnet"
    resource_group_name  = "rg-paratp"
    location             = "West US 2"
    address_space        = ["10.0.0.0/16"]
  }
}
vms = {
  vms1 = {
    pip_name             = "pip_vm_1"
    resource_group_name  = "rg-paratp"
    location             = "West US 2"
    snet_name            = "subnet_frontend"
    virtual_network_name = "vnet"
    data_pip_name        = "data_pip_1"
    data_snet_name       = "data_snet_1"
    nic_name             = "nic_1"
    vm_name              = "Fronetend_Vm"
    nsg_name             = "frontend-nsg"
  }
}

