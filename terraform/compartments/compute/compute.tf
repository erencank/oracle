# https://docs.oracle.com/en-us/iaas/developer-tutorials/tutorials/tf-simple-infrastructure/01-summary.htm
data "oci_identity_availability_domains" "ads" {
  compartment_id = var.compartment_id
}

resource "random_string" "compute_name" {
  length  = 8
  special = false
}

resource "oci_core_instance" "tf_compute" {
  # Required
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id      = var.compartment_id
  shape               = var.compute_shape

  source_details {
    source_id   = var.compute_image_id
    source_type = "image"
  }

  # Optional
  display_name = "${var.compute_name}.${random_string.compute_name.result}"

  shape_config {
    ocpus         = var.compute_cpus
    memory_in_gbs = var.compute_memory_in_gbs
  }

  create_vnic_details {
    subnet_id = var.compute_subnet_id
    # subnet_id        = "ocid1.subnet.oc1.eu-amsterdam-1.aaaaaaaaqxbop3q54ear3gd653nfuoibrk7go27d5zvslzvtbpo6vvwt6szq"
    assign_public_ip = true
  }

  metadata = {
    ssh_authorized_keys = file(var.compute_ssh_authorized_keys)
  }

  preserve_boot_volume = false
}

# ocid1.subnet.oc1.eu-amsterdam-1.aaaaaaaaqxbop3q54ear3gd653nfuoibrk7go27d5zvslzvtbpo6vvwt6szq
