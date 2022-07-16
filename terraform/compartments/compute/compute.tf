# https://docs.oracle.com/en-us/iaas/developer-tutorials/tutorials/tf-simple-infrastructure/01-summary.htm

locals {
  compartment_id = var.compartment_id
  vcn_id         = var.compute_vcn_id
  all_cidr       = "0.0.0.0/0"
  current_time   = formatdate("YYYYMMDDhhmmss", timestamp())
  app_name       = "oci-dev-kit"
  display_name   = join("-", [local.app_name, local.current_time])
}

data "oci_identity_availability_domains" "ads" {
  compartment_id = var.compartment_id
}

resource "random_string" "compute_name" {
  length  = 8
  special = false
}

# Security group
resource "oci_core_network_security_group" "nsg" {
  compartment_id = local.compartment_id                   # Required
  vcn_id         = local.vcn_id                           # Required
  display_name   = "${local.display_name}-security-group" # Optional
  # freeform_tags  = var.common_tags
}

resource "oci_core_network_security_group_security_rule" "ingress_ssh" {
  network_security_group_id = oci_core_network_security_group.nsg.id # Required
  direction                 = "INGRESS"                              # Required
  protocol                  = "6"                                    # Required
  source                    = local.all_cidr                         # Required
  source_type               = "CIDR_BLOCK"                           # Required
  stateless                 = false                                  # Optional
  tcp_options {                                                      # Optional
    destination_port_range {                                         # Optional         
      max = "22"                                                     # Required
      min = "22"                                                     # Required
    }
  }
  description = "ssh only allowed" # Optional
}

resource "oci_core_network_security_group_security_rule" "ingress_icmp_3_4" {
  network_security_group_id = oci_core_network_security_group.nsg.id # Required
  direction                 = "INGRESS"                              # Required
  protocol                  = "1"                                    # Required
  source                    = local.all_cidr                         # Required
  source_type               = "CIDR_BLOCK"                           # Required
  stateless                 = false                                  # Optional
  icmp_options {                                                     # Optional
    type = "3"                                                       # Required
    code = "4"                                                       # Required
  }
  description = "icmp option 1" # Optional
}

resource "oci_core_network_security_group_security_rule" "ingress_icmp_3" {
  network_security_group_id = oci_core_network_security_group.nsg.id # Required
  direction                 = "INGRESS"                              # Required
  protocol                  = "1"                                    # Required
  source                    = "10.0.0.0/16"                          # Required
  source_type               = "CIDR_BLOCK"                           # Required
  stateless                 = false                                  # Optional
  icmp_options {                                                     # Optional
    type = "3"                                                       # Required
  }
  description = "icmp option 2" # Optional
}

resource "oci_core_network_security_group_security_rule" "egress" {
  network_security_group_id = oci_core_network_security_group.nsg.id # Required
  direction                 = "EGRESS"                               # Required
  protocol                  = "6"                                    # Required
  destination               = local.all_cidr                         # Required
  destination_type          = "CIDR_BLOCK"                           # Required
  stateless                 = false                                  # Optional
  description               = "connect to any network"
}

# Compute Instance
resource "oci_core_instance" "tf_compute" {
  # Required
  availability_domain  = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id       = local.compartment_id
  shape                = var.compute_shape
  preserve_boot_volume = false
  # freeform_tags        = var.common_tags


  source_details {
    source_id   = var.compute_image_id
    source_type = "image"
  }

  # Optional
  # display_name = "${local.display_name}.${random_string.compute_name.result}"

  shape_config {
    ocpus         = var.compute_cpus
    memory_in_gbs = var.compute_memory_in_gbs
  }

  create_vnic_details {
    subnet_id = var.compute_subnet_id
    # subnet_id        = "ocid1.subnet.oc1.eu-amsterdam-1.aaaaaaaaqxbop3q54ear3gd653nfuoibrk7go27d5zvslzvtbpo6vvwt6szq"
    assign_public_ip = true
    nsg_ids          = [oci_core_network_security_group.nsg.id]
  }

  metadata = {
    ssh_authorized_keys = file(var.compute_ssh_authorized_keys)
  }
}
