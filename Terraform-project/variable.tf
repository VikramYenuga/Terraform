variable "rds-password" {
    description = "rds password"
    type = string
    default = "Vikram123"
  
}
variable "rds-username" {
    description = "rds username"
    type = string
    default = "admin"
  
}
variable "ami" {
    description = "ami"
    type = string
    default = "ami-01760eea5c574eb86"
  
}
variable "instance-type" {
    description = "instance-type"
    type = string
    default = "t3.micro"
  
}
variable "key_name" {
    description = "keyname"
    type = string
    default = "test"
  
}
variable "backupr-retention" {
    type = number
    default = "1"
  
}