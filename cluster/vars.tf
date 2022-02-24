variable "region" {
  type    = string
  default = "us-east-2"
}

variable "cluster_tag_key" {
  type    = string
  default = "consul"
}

variable "cluster_tag_value" {
  type    = string
  default = "dc1"
}

variable "ssh_key_name" {
  type    = string
}

variable "allowed_ssh" {
    type = list(string)
    default = [""]
}