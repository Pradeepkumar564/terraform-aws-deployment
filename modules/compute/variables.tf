
variable "environment" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "ami_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "allowed_ssh_cidr" {
  type    = string
  default = ""
}
