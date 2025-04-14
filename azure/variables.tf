variable "cluster_name" {
  description = "Cluster name for resources"
  type        = string
}
 
variable "location" {
  description = "Azure region"
  type        = string
  default     = "East US"
}
 
variable "num_nodes" {
  description = "Number of VMs to create"
  type        = number
  default     = 1
}
 
