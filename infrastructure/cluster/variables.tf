variable "rhcs_token" {
  description = "RHCS API token for authentication"
  type        = string
  
}

variable "admin_credentials_username" {
  description = "Admin username for the OpenShift cluster"
  type        = string
}
variable "admin_credentials_password" {
  description = "Admin password for the OpenShift cluster"
  type        = string
}