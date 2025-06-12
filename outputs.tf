output "resource_group_name" {
  value = module.rg.name
}

output "vnet_id" {
  value = module.vnet.id
}

output "load_balancer_ip" {
  value = module.lb.public_ip
}

output "vmss_id" {
  value = module.vmss.vmss_id
}
