variable "ami_info" {
  type        = string
  description = "amazon machine image id"
  default     = "ami-0522ab6e1ddcc7055"
}
variable "vpc_info" {
  type        = object({
    cidr_block = string 
  })
  description = "vpc information"

}
variable "public_subnets" {
  type = list(object({
    cidr_block       = string
    available_region = string
    tags = map(string)
  }))
  description = "public subnets configuration"
}
variable "private_subnets" {
  type = list(object({
    cidr_block       = string
    available_region = string
    tags = map(string)
  }))
  description = "private subnets configuration"
}
variable "web_security_group_info" {
  type = list(object({
    from_port   = number
    to_port     = number
    ip_protocol = string
    cidr_ipv4   = string
  }))
  description = "web security group info"
}
variable "db_security_group_info" {
  type = list(object({
    from_port   = number
    to_port     = number
    ip_protocol = string
    cidr_ipv4   = string
  }))
  description = "db security group info"
}
variable "lb_security_group_info" {
  type = list(object({
    from_port   = number
    to_port     = number
    ip_protocol = string
    cidr_ipv4   = string
  }))
  description = "lb security group info"
}
variable "ec2_info" {
  type = object({
    name          = string
    instance_type = string
    key_name      = string

  })
  description = "ec2 instance info"

}