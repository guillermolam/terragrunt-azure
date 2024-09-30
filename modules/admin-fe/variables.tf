variable "environment" {
  type    = string
  default = "non-prod"
}

variable "location" {
  type    = string
  default = "France Central"
}

variable "storage_account_tier" {
  type = string
}

variable "storage_account_replication" {
  type = string
}