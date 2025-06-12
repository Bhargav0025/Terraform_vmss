terraform {
  required_version = ">= 1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "118d885d-02d0-4515-b9fd-fbe3ac07767f"

}

module "rg" {
  source   = "./modules/resource_group"
  name     = var.resource_group_name
  location = var.location
}

module "vnet" {
  source              = "./modules/vnet"
  name                = var.vnet_name
  location            = var.location
  resource_group_name = module.rg.name
  address_space       = var.vnet_address_space
  subnets             = var.subnets
}

module "lb" {
  source              = "./modules/load_balancer"
  name                = var.lb_name
  location            = var.location
  resource_group_name = module.rg.name
  frontend_port       = 80
  backend_port        = 80
  health_probe_port   = 80
  health_probe_path   = "/"
}

module "nsg" {
  source              = "./modules/nsg"
  name                = var.nsg_name
  location            = var.location
  resource_group_name = module.rg.name
  load_balancer_ip    = module.lb.public_ip
  vm_port             = "80"
}

resource "azurerm_subnet_network_security_group_association" "subnet_nsg_assoc" {
  subnet_id                 = module.vnet.subnet_ids[0]
  network_security_group_id = module.nsg.id
}

module "vmss" {
  source              = "./modules/vmss"
  name                = var.vmss_name
  location            = var.location
  resource_group_name = module.rg.name
  vm_sku              = "Standard_B2s"
  instance_count      = 2
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  subnet_id           = module.vnet.subnet_ids[0]
  backend_pool_id     = module.lb.backend_pool_id
  health_probe_id     = module.lb.health_probe_id
}

module "autoscale" {
  source                 = "./modules/autoscale"
  name                   = var.vmss_name
  resource_group_name    = module.rg.name
  location               = var.location
  vmss_id                = module.vmss.vmss_id
  default_instance_count = 2
  min_instance_count     = 1
  max_instance_count     = 3
  scale_out_threshold    = 80
  scale_in_threshold     = 10
}
