provider "azurerm" {
  features {}

}
resource "azurerm_resource_group" "rg" {
  name     = "${var.cluster_name}-rg"
  location = var.location
}
 
resource "azurerm_storage_account" "sa" {
  name                     = "${var.cluster_name}storage"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
 
resource "azurerm_storage_container" "tfstate" {
  name                  = "${var.cluster_name}-tfstate"
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "private"
}
 
 
