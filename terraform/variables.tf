variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "app_tag" {}
variable "environment" {}
variable "region" {}
variable "vcn_cidr" {
  default = "10.0.0.0/16"
}
variable "subnet_cidr" {
  default = "10.0.0.0/24"
}


variable "compute_shape" { type = string }
variable "compute_name" { type = string }
variable "compute_subnet_id" { type = string }
variable "compute_image_id" { type = string }
variable "compute_ssh_authorized_keys" { type = string }
