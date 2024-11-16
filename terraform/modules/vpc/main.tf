resource "azurerm_virtual_network" "main" {
  name                = "${var.project_name}-vnet-${var.environment}"
  address_space       = [var.vpc_cidr]
  location            = var.region
  resource_group_name = var.project_name
}

resource "azurerm_subnet" "public" {
  name                 = "${var.project_name}-public-subnet-${var.environment}"
  resource_group_name  = var.project_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [var.public_subnet_cidr]
}
