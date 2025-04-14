variable "cluster_name" {
  description = "Cluster name for VM resources"
  type        = string
}
 
variable "location" {
  description = "Azure location"
  type        = string
}
 
variable "resource_group" {
  description = "Resource Group name"
  type        = string
}
 
variable "node_count" {
  description = "Number of VMs to create"
  type        = number
}
 
