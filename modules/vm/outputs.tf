output "vm_names" {
  value = [for vm in azurerm_linux_virtual_machine.vm : vm.name]
}
 
