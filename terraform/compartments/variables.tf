variable "tenancy_ocid" {}
variable "app_tag" {}
variable "environment" {}
variable "common_tags" {}
variable "compute" {
  type = object({
    compute_name                = string
    compute_vcn_id              = string
    compute_subnet_id           = string
    compute_image_id            = string
    compute_ssh_authorized_keys = string
    compute_shape               = string
  })
}
