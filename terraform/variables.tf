variable "project_name" {
  description = "The name of the project"
  default     = "myproject"
}

variable "environment" {
  description = "The environment (e.g., dev, staging, prod)"
  default     = "dev"
}

variable "region" {
  description = "Azure region to deploy resources"
  default     = "East US"
}

variable "client_id" {
  description = "Azure client ID (appId)"
}

variable "client_secret" {
  description = "Azure client secret (password)"
}

variable "tenant_id" {
  description = "Azure tenant ID"
}

variable "subscription_id" {
  description = "Azure subscription ID"
}

variable "vpc_cidr" {
  description = "CIDR block for the VNet"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet"
  default     = "10.0.2.0/24"
}

variable "instance_type" {
  description = "VM size"
  default     = "Standard_B1s"
}

variable "db_username" {
  description = "Database username"
  default     = "your_db_user"
}

variable "db_password" {
  description = "Database password"
}
    