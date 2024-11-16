module "vpc" {
  source           = "./modules/vpc"
  project_name     = var.project_name
  environment      = var.environment
  vpc_cidr         = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
}

module "lb" {
  source           = "./modules/lb"
  project_name     = var.project_name
  environment      = var.environment
}

module "web_server" {
  source           = "./modules/web_server"
  project_name     = var.project_name
  environment      = var.environment
}

module "db" {
  source           = "./modules/db"
  project_name     = var.project_name
  environment      = var.environment
  db_username      = var.db_username
  db_password      = var.db_password
}
