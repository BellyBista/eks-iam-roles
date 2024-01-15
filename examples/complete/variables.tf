variable "pgp_key" {
  type        = string
  default     = "keybase:quadribello41"
  description = "PGP key used for encrypting user login profiles"
}


variable "developer" {
  type        = list(string)
  default     = ["developer1", "developer2"]
  description = "List  developer users"
}

variable "admin" {
  type        = list(string)
  default     = ["admin1"]
  description = "List of  admin users"
}