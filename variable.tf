
variable "aws_region" {
   default = "ap-southeast-2"
}

variable "vpc_cidr" {
   default = "172.90.0.0/16"
}

variable "subnet_pb_cidr" {
   type = "list"
   default = ["172.90.10.0/24","172.90.20.0/24"]
}


variable "azs_pb" {
  type = "list"
  default = ["ap-southeast-2a", "ap-southeast-2b"]
}

variable "azs_db" {
  default = "ap-southeast-2c"
}

variable "webservers_ami" {
   default = "ami-058230133c539c49c"
}

variable "instance_type" {
   default = "t2.micro"
}



