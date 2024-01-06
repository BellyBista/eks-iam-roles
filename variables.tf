variable "node_group_name" {
  type = string
  default = "eks-node-group-nodes"
  description = "(Optional) The name of the role policy. If omitted, Terraform will assign a random, unique name."
}

variable "cluster_role_name" {
  type = string
  default = "eks-cluster"
  description = "(Optional) The name of the role policy. If omitted, Terraform will assign a random, unique name."
}