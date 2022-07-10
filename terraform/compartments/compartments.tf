resource "oci_identity_compartment" "networks" {
  description = "The networks compartment"
  name        = "${var.app_tag}_${var.environment}_networks"
}

resource "oci_identity_compartment" "admin" {
  description = "The admin compartment"
  name        = "${var.app_tag}_${var.environment}_admin"
}

resource "oci_identity_compartment" "shared_services" {
  description = "The shared_services compartment"
  name        = "${var.app_tag}_${var.environment}_shared_services"
}

resource "oci_identity_compartment" "business_logic" {
  description = "The business_logic compartment"
  name        = "${var.app_tag}_${var.environment}_business_logic"
}

resource "oci_identity_compartment" "database" {
  description = "The database compartment"
  name        = "${var.app_tag}_${var.environment}_database"
}