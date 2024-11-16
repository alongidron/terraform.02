resource "azurerm_lb" "app_lb" {
  name                = "${var.project_name}-lb-${var.environment}"
  location            = var.region
  resource_group_name = var.project_name
}

output "lb_dns_name" {
  value = azurerm_lb.app_lb.id
}
