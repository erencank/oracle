# # Outputs for the vcn module

output "vcn" {
  value = oci_core_vcn.vcn
}

output "subnet" {
  value = oci_core_subnet.regional_sn
}
