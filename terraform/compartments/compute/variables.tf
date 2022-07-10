# Variables
variable "compartment_id" { type = string }
variable "compute_name" { type = string }
variable "compute_subnet_id" { type = string }
variable "compute_image_id" { type = string }
variable "compute_ssh_authorized_keys" { type = string }

variable "compute_shape" {
  type    = string
  default = "VM.Standard.A1.Flex"
}

variable "compute_cpus" {
  type    = number
  default = 4
}

variable "compute_memory_in_gbs" {
  type    = number
  default = 24
}
