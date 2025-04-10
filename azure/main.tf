provider "azurerm" {
  features {}
}
 
resource "azurerm_resource_group" "rg" {
  name     = "${var.cluster_name}-rg"
  location = "East US"
}
 
resource "azurerm_storage_account" "tfstate" {
  name                     = "${var.cluster_name}storage"
resource_group_name = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
 
resource "azurerm_storage_container" "tfstate" {
  name                  = "${var.cluster_name}-tfstate"
storage_account_name = azurerm_storage_account.tfstate.name
  container_access_type = "private"
}
 
module "vm_cluster" {
  source         = "./modules/vm"
  cluster_name   = var.cluster_name
  location       = azurerm_resource_group.rg.location
resource_group = azurerm_resource_group.rg.name
  num_nodes      = var.num_nodes
}