terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.81.0"
    }
  }
}

provider "azurerm" {
  features {}
}

data "terraform_remote_state" "storage" {
  backend = "azurerm"
  config = {
    storage_account_name = "terraform123abc"
    container_name       = "terraform-state"
    key                  = "prod.terraform.tfstate"
  }
}


/*
  resource "azurerm_resource_group" "myrg" {
  name     = "${var.environment}-${var.resource_group_name}"
  location = var.location
  # other properties...
}
*/

data "azurerm_resource_group" "existing_rg" {
  name = "kafka-eun-${var.environment}-ep-rg-0001"
}


output "rg_name" {
  value = data.azurerm_resource_group.existing_rg.name
}

resource "azurerm_sql_server" "mysql" {
  name                         = var.sql_server_name
  resource_group_name          = var.azurerm_resource_group.myrg.name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.admin_login
  administrator_login_password = var.admin_password
  
tags = {
    "EA_Application_ID": "A2329",
    "EA_Business_Platform": "",
    "EA_Primary_Product": "events-platform",
    "EA_Product_Portfolio": "",
    "Environment"= var.environment,
    "IOCode": "EC000442",
    "Subscription_Type": "Cloud Native",  
}
}
resource "azurerm_mssql_database" "test" {
  name           = var.sql_db_name
  server_id      = azurerm_sql_server.mysql.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = 1
  read_scale     = false
  sku_name       = "S0"
  zone_redundant = false
  

  tags = {
    "EA_Application_ID": "A2329",
    "EA_Business_Platform": "",
    "EA_Primary_Product": "events-platform",
    "EA_Product_Portfolio": "",
    "Environment"= var.environment,
    "IOCode": "EC000442",
    "Subscription_Type": "Cloud Native",
  }
}