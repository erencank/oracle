locals {
  common_tags = {
    Reference = "erencank-terraform-config"
  }
}

module "compartments" {
  source       = "./compartments"
  tenancy_ocid = var.tenancy_ocid
  app_tag      = var.app_tag
  environment  = var.environment
  common_tags  = local.common_tags
  compute = {
    compute_shape               = "${var.compute_shape}"
    compute_name                = "${var.compute_name}"
    compute_vcn_id              = "${module.vcn.vcn.id}"
    compute_subnet_id           = "${module.vcn.subnet.id}"
    compute_image_id            = "${var.compute_image_id}"
    compute_ssh_authorized_keys = "${var.compute_ssh_authorized_keys}"
  }
}

module "vcn" {
  source           = "./vcn"
  compartment_ocid = module.compartments.compartment_id
  common_tags      = local.common_tags
}
