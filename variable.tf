variable "resource_group_name" {
  description = "The name of the Azure Resource Group"
  type        = string
}

variable "location" {
  description = "The Azure region in which to create resources"
  type        = string
}

variable "environment" {
  description = "env name"
  type        = string 
}

variable "admin_login" {
  description = "The SQL Server administrator login"
  type        = string
}

variable "admin_password" {
  description = "The SQL Server administrator password"
  type        = string
}

variable "sql_server_name" {
  description = "The name of the SQL Server"
  type        = string
}


variable "sql_db_name" {
  description = "The name of the SQL Database"
  type        = string
}
