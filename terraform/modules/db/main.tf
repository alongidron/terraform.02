resource "azurerm_postgresql_server" "db" {
  name                = "${var.project_name}-db-${var.environment}"
  location            = var.region
  resource_group_name = var.project_name
  administrator_login = var.db_username
  administrator_login_password = var.db_password
}

output "db_endpoint" {
  value = azurerm_postgresql_server.db.fqdn
}
