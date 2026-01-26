variable "ami" {
  default="ami-0220d79f3f480ecf5"
}
variable "instance_type" {
  default="t2.micro"
}
variable "zone_id"{
  default="Z08520602FC482APPVUI7"
}
# variable "components"{
#   default = ["frontend","catalogue","cart","users","mongodb"]
# }
variable "role" {
  default = "test-role-2"
}
variable "policy"{
  default = "test-policy-2"
}
variable "instance_profile"{
  default = "instance_profile-2"
}
variable "env" {
  default = "dev"
}
variable "components" {
  default = {
    frontend    =   ""

  }
}