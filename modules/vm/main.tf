resource "azurerm_network_security_group" "nsg" {
  name                = "${var.cluster_name}-nsg"
  location            = var.location
  resource_group_name = var.resource_group
}
 
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.cluster_name}-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group
}
 
resource "azurerm_subnet" "subnet" {
  name                 = "default"
  resource_group_name  = var.resource_group
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}
 
resource "azurerm_network_interface" "nic" {
  count               = var.num_nodes
  name                = "${var.cluster_name}-nic-${count.index}"
  location            = var.location
  resource_group_name = var.resource_group
 
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}
 
resource "azurerm_linux_virtual_machine" "vm" {
  count               = var.num_nodes
  name                = "${var.cluster_name}-vm-${count.index}"
  resource_group_name = var.resource_group
  location            = var.location
  size                = "Standard_B1s"
  admin_username      = "azureuser"
  network_interface_ids = [
    azurerm_network_interface.nic[count.index].id
  ]
  admin_password = "P@ssword1234!" # use Key Vault in real setup
 
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
 
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
 