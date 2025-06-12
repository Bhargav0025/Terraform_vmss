output "public_ip" {
  value = azurerm_public_ip.this.ip_address
}

output "backend_pool_id" {
  value = azurerm_lb_backend_address_pool.this.id
}

output "health_probe_id" {
  value = azurerm_lb_probe.http_probe.id
}

