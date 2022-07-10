variable "fingerprint" {
  description = "API Key Fingerprint"
  type = string
}

variable "region" {
  description = "Oracle Region Name"
  type = string
  default = "eu-amsterdam-1"
}

variable "user_ocid" {
    description = "User OCID"
    type = string
}

variable "tenancy_ocid" {
  description = "Tenancy OCID"
  type = string
}