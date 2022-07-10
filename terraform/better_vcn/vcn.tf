# https://docs.oracle.com/en-us/iaas/developer-tutorials/tutorials/tf-vcn/01-summary.htm

module "vcn" {
  source  = "oracle-terraform-modules/vcn/oci"
  version = "3.1.0"

  # Required Inputs
  compartment_id = var.compartment_ocid
  region         = var.region

  internet_gateway_route_rules = null
  local_peering_gateways       = null
  nat_gateway_route_rules      = null

  # Optional Inputs
  vcn_name      = "vcn-module"
  vcn_dns_label = "vcnmodule"
  vcn_cidrs     = [var.vcn_cidr]

  create_internet_gateway = true
  create_nat_gateway      = true
  create_service_gateway  = true
}
