variable "compartment_ocid" {
  description = "OCID of the compartment where the VCN is being created"
  type        = string
}

variable "common_tags" {
  description = "Tags"
  type        = map(string)
}
