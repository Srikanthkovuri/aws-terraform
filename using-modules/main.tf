module "vpc" {
  source          = "terraform-aws-modules/vpc/aws"
  count = length(var.vpc_info)
  name            = var.vpc_info[count.index].name
  cidr            = var.vpc_info[count.index].cidr_block
  azs             = [var.public_subnets[count.index].azs, var.public_subnets[count.index].azs]
  public_subnets  = [var.public_subnets[count.index].cidr_block]
  private_subnets = [var.private_subnets[count.index].cidr_block]
  tags = {
    Environment = "dev"
  }
}
module "web_service_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "web-sg"
  description = "Security group for user-service with custom ports open within VPC, and PostgreSQL publicly open"
  vpc_id      = module.vpc[0].vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = var.security_group_info[0].from_port
      to_port     = var.security_group_info[0].to_port
      protocol    = var.security_group_info[0].protocol
      cidr_blocks = var.security_group_info[0].cidr_blocks
      description = "User-service ports"
      
    },
    {
      from_port   = var.security_group_info[1].from_port
      to_port     = var.security_group_info[1].to_port
      protocol    = var.security_group_info[1].protocol
      cidr_blocks = var.security_group_info[1].cidr_blocks
    },
  ]
  egress_with_cidr_blocks = [
    {
      type = "egress"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
    }
  ]
}
module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = var.ec2_info.name

  instance_type          = var.ec2_info.instance_type
  key_name               = var.ec2_info.key_name
  associate_public_ip_address = true
  user_data = filebase64("oxer.sh")
  vpc_security_group_ids = [module.web_service_sg.security_group_id]
  subnet_id              = module.vpc[0].public_subnets[0]
  ami                    = var.ec2_info.ami

  tags = {
    Environment = "dev"
  }
}
