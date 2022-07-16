resource "oci_identity_compartment" "tf-compartment" {
  # Required
  compartment_id = var.tenancy_ocid
  description    = "Compartment for Terraform resources."
  name           = "${var.app_tag}_${var.environment}_tf-compartment"
}

module "compute" {
  source                      = "./compute"
  compartment_id              = oci_identity_compartment.tf-compartment.id
  compute_name                = var.compute.compute_name
  compute_vcn_id              = var.compute.compute_vcn_id
  compute_subnet_id           = var.compute.compute_subnet_id
  compute_image_id            = var.compute.compute_image_id
  compute_ssh_authorized_keys = var.compute.compute_ssh_authorized_keys
}
