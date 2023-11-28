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

terraform {
  backend "azurerm" {
    resource_group_name  = "StorageAccount-ResourceGroup"
    storage_account_name = "abcd1234"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
    use_oidc             = true
    subscription_id      = "83d5cfeb-365c-424e-bff4-33ac28574f76"
    tenant_id            = "c9e766e1-d0c5-4b4d-8dc9-d4e7c0615230"
  }
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