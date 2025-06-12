resource "azurerm_public_ip" "this" {
  name                = "${var.name}-publicip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_lb" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.this.id
  }
}

resource "azurerm_lb_backend_address_pool" "this" {
  name                = "${var.name}-bepool"
  loadbalancer_id     = azurerm_lb.this.id
}

resource "azurerm_lb_probe" "http_probe" {
  name                = "HealthProbe"
  loadbalancer_id     = azurerm_lb.this.id
  protocol            = "Http"
  port                = var.health_probe_port
  request_path        = var.health_probe_path
  interval_in_seconds = 15
  number_of_probes    = 2
}

resource "azurerm_lb_rule" "http" {
  name                           = "HTTPRule"
  loadbalancer_id                = azurerm_lb.this.id
  frontend_ip_configuration_name = "PublicIPAddress"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.this.id] # <-- NOTE: Use plural form
  probe_id                       = azurerm_lb_probe.http_probe.id
  protocol                       = "Tcp"
  frontend_port                  = var.frontend_port
  backend_port                   = var.backend_port
  idle_timeout_in_minutes        = 5
  enable_floating_ip             = false
}
