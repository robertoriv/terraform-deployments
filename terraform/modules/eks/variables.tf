variable "cluster_name" {
  description = "Name of the cluster"
}

variable "cluster_version" {
  description = "Cluster version number"
  default     = "1.19"
}

variable "subnet_ids" {
  description = "Subnet Ids to which the cluster and nodes are deployed"
  type        = list(string)
}

variable "vpc_id" {
  description = "The VPC to which the cluster is deployed"
}
