output "compute_id" {
  value = oci_core_instance.tf_compute.id
}

output "db_state" {
  value = oci_core_instance.tf_compute.state
}

output "compute_public_ip" {
  value = oci_core_instance.tf_compute.public_ip
}

output "metadata" {
  value = oci_core_instance.tf_compute.metadata
}
