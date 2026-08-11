module "example" {
  source = "../../modules/rg"
  rgs    = var.rgs

}

module "pip" {
  source     = "../../modules/publicip"
  pip        = var.pip
  depends_on = [module.example]
}
module "vnet" {
  vnet       = var.vnet
  source     = "../../modules/vnet"
  depends_on = [module.example]

}
module "snet" {
  snet       = var.snet
  source     = "../../modules/snet"
  depends_on = [module.vnet]

}
module "main" {
  vms        = var.vms
  source     = "../../modules/vm"
  depends_on = [module.snet, module.pip]

}
output "vm_public_ip" {
  depends_on = [module.main]
  value      = module.main.vm_public_ip
}

