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

resource "azurerm_resource_group" "myrg" {
  name     = var.resource_group_name
  location = "West Europe"
}


resource "azurerm_sql_server" "mysql" {
  name                         = var.sql_server_name
  resource_group_name          = azurerm_resource_group.myrg.name
  location                     = azurerm_resource_group.myrg.location
  version                      = "12.0"
  administrator_login          = var.admin_login
  administrator_login_password = var.admin_password
  
tags = {
    "EA_Application_ID": "A2329",
    "EA_Business_Platform": "",
    "EA_Primary_Product": "events-platform",
    "EA_Product_Portfolio": "",
    "Environment": "Non Production",
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
    "Environment": "Non Production",
    "IOCode": "EC000442",
    "Subscription_Type": "Cloud Native",
  }
}