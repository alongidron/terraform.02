resource "azurerm_linux_virtual_machine" "app" {
  name                = "${var.project_name}-web-server-${var.environment}"
  resource_group_name = var.project_name
  location            = var.region
  size                = var.instance_type
}
