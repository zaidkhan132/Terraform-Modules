variable "cluster_name" {
  description = "Cluster name for resources"
  type        = string
}
 
variable "location" {
  description = "Azure region"
  type        = string
  default     = "East US"
}
 
variable "node_count" {
  description = "Number of nodes to deploy"
  type        = number
}
 
