provider "azurerm" {
  features {}
 
  client_id       = "0e1ba460-1ab8-4a2d-9244-54332e376fde"
  client_secret   = "4LD8Q~IyP5NsQYkMM0~5tiGxebLl8~1TocTm~dtD"
  tenant_id       = "c10f8df0-e818-4423-b387-68ce113e39cc"
  subscription_id = "03eddb61-8398-483b-9327-8dc016e1af21"
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
 
module "vm_cluster" {
  source         = "../modules/vm"
  cluster_name   = var.cluster_name
  location       = var.location
  resource_group = azurerm_resource_group.rg.name
  node_count     = var.num_nodes
}
 
