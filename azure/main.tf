provider "azurerm" {
  features {}

 ARM_CLIENT_ID="2f567ba8-5e4e-4e64-adbe-6207512c9394"
 ARM_CLIENT_SECRET="01z8Q~r5pQQUe~rKwOt-aEXE-QhgApywXa~tWcZ4"
 ARM_SUBSCRIPTION_ID="03eddb61-8398-483b-9327-8dc016e1af21"
 ARM_TENANT_ID="45868572-7edb-4db3-9dcf-6c49b63c9c8c"
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
 
