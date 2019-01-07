variable "cluster-name" {
  default = "terraform-eks-demo"
  type    = "string"
}
variable "region" {
  default="eu-west-1"  
}
variable "profile" {
  default="aws-profile"
}
variable "vpc_name" {
  defult="testalb"
  
}


variable "key_name" {
  description = " Instance key to login"
  
}
