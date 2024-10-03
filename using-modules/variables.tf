variable "vpc_info" {
    type = list(object({
      name = string
      cidr_block = string
    }))
    description = "Vpc information"
}
variable "public_subnets" {
  type = list(object({
    cidr_block = string
    azs = string
  }))
  description = "public subnets configuration"
}
variable "private_subnets" {
  type = list(object({
    cidr_block = string
    azs = string
  }))
  description = "private subnets configuration"
}
variable "security_group_info" {
  type = list(object({
    from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = string
  }))
  description = "security group info"
}
variable "ec2_info" {
    type = object({
      name = string
      instance_type          = string
      key_name               = string
      ami = string

    })
    description = "ec2 instance info"
  
}