variable "AWS_REGION" {
	default = "us-east-1"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "devopskey"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "devopskey.pub"
}

variable "AMIS" {
type = "map"
default = {
	us-east-1 = "ami-0de53d8956e8dcf80"
	us-east-2 = "ami-0080e4c5bc078760e"
	us-west-1 = "ami-011b3ccf1bd6db744"
	}
}

variable "instance_type" {
  default     = "t2.micro"
  description = "AWS instance type to create machine"
}
