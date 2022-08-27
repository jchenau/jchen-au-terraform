variable "org_id" {
  type    = string
  default = "696719866582"
}

variable "project_id" {
  type = string
}

variable "location" {
  type    = string
  default = "australia-southeast1"
}

variable "zone" {
  type    = string
  default = "australia-southeast1-c"
}

variable "enabled_apis" {
  type = list(string)
}
