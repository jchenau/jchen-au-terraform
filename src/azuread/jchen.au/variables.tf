variable "tenant_id" {
  type    = string
  default = "f4afa40c-a163-4116-a3d9-2ea45bb358fa"
}

variable "groups" {
  type = map(list(string))
}
