  variable "myami" {
  default      = "ami-0c2b8ca1dad447f8a"
 }
 
  variable "instancetype" {
   default     = "t2.micro"
 }

  variable "az1" {
    default   = "us-east-1a"
 }
 variable "az2" {
    default   = "us-east-1"
 }
  
  
  variable "keyname" {
    default           = "taas-kp"
 }
   variable "vpccidrblock" {
    type       = string
 }
  variable "publicsubnet1cidrblock" {
    type       = string
 }
 variable "privatesubnet1cidrblock" {
    type       = string
 }
 variable "publicsubnet2cidrblock" {
    type       = string
 }
 variable "privatesubnet2cidrblock" {
    type       = string
 }
variable "sgcidrblock" {
    type       = string
 }

