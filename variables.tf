variable "ami" {
  default="ami-09c813fb71547fc4f"
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

variable "components" {
  default = {
    frontend    =   ""
    catalogue   =   ""

  }
}