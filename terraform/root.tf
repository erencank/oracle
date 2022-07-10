module "compartments" {
  source       = "./compartments"
  tenancy_ocid = var.tenancy_ocid
  app_tag      = var.app_tag
  environment  = var.environment
  compute = {
    compute_shape               = "${var.compute_shape}"
    compute_name                = "${var.compute_name}"
    compute_subnet_id           = "${module.b_vcn.public-subnet-OCID}"
    compute_image_id            = "${var.compute_image_id}"
    compute_ssh_authorized_keys = "${var.compute_ssh_authorized_keys}"
  }
  providers = {
    oci = "oci"
  }
}

module "b_vcn" {
  source           = "./better_vcn"
  tenancy_ocid     = var.tenancy_ocid
  compartment_ocid = module.compartments.compartment_id
  app_tag          = var.app_tag
  environment      = var.environment
  vcn_cidr         = var.vcn_cidr
  subnet_cidr      = var.subnet_cidr
  region           = var.region
}
