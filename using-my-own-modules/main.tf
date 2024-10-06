module "vpc" {
  source = "git::https://github.com/Srikanthkovuri/Terraform-modules.git//aws/vpc"
  vpc_config = {
    cidr_block           = var.vpc_info.cidr_block
    enable_dns_hostnames = true
    tags = {
      Name        = "my-vpc"
      Purpose     = "webapp"
      Environment = "Dev"
    }
  }
  public_subnet_config = [{
    cidr_block       = var.public_subnets[0].cidr_block
    available_region = var.public_subnets[0].available_region
    tags = {
      Name = "web-1"
    }
    },
    {
    cidr_block       = var.public_subnets[1].cidr_block
    available_region = var.public_subnets[1].available_region
    tags = {
      Name = "web-2"
    }
    }
  ]
  private_subnet_config = [{
    cidr_block       = var.private_subnets[0].cidr_block
    available_region = var.private_subnets[0].available_region
    tags = {
      Name = "db-1"
    }
  },
  {
    cidr_block       = var.private_subnets[1].cidr_block
    available_region = var.private_subnets[1].available_region
    tags = {
      Name = "db-2"
    }
  }]

}

# Web security group to open 5000 port 
module "websg" {
  source = "git::https://github.com/Srikanthkovuri/Terraform-modules.git//aws/securitygrp"
  vpc_id = module.vpc.id
  #count  = length(var.web_security_group_info)
  security_group_info = {
    name        = "webapp"
    description = "security group for nop"
    inbound_rules = [{
      from_port   = var.web_security_group_info[0].from_port
      ip_protocol = var.web_security_group_info[0].ip_protocol
      to_port     = var.web_security_group_info[0].to_port
      cidr_ipv4   = var.web_security_group_info[0].cidr_ipv4
      description = "open ssh port"
    },
    {
      from_port   = var.web_security_group_info[1].from_port
      ip_protocol = var.web_security_group_info[1].ip_protocol
      to_port     = var.web_security_group_info[1].to_port
      cidr_ipv4   = var.web_security_group_info[1].cidr_ipv4
      description = "open nop port"
    }
  ]
  }
}
module "dbsg" {
  source = "git::https://github.com/Srikanthkovuri/Terraform-modules.git//aws/securitygrp"
  vpc_id = module.vpc.id
  count  = length(var.db_security_group_info)
  security_group_info = {
    name        = "db-sg"
    description = "security group for mysql"
    inbound_rules = [{
      from_port   = var.db_security_group_info[count.index].from_port
      ip_protocol = var.db_security_group_info[count.index].ip_protocol
      to_port     = var.db_security_group_info[count.index].to_port
      cidr_ipv4   = var.db_security_group_info[count.index].cidr_ipv4
      description = "open mysql port"
      }

    ]
  }
}
module "lbsg" {
  source = "git::https://github.com/Srikanthkovuri/Terraform-modules.git//aws/securitygrp"
  vpc_id = module.vpc.id
  count  = length(var.lb_security_group_info)
  security_group_info = {
    name        = "lb-sg"
    description = "security group for http"
    inbound_rules = [{
      from_port   = var.lb_security_group_info[count.index].from_port
      ip_protocol = var.lb_security_group_info[count.index].ip_protocol
      to_port     = var.lb_security_group_info[count.index].to_port
      cidr_ipv4   = var.lb_security_group_info[count.index].cidr_ipv4
      description = "open http port"
      }

    ]
  }
}
module "asgwithlb" {
  source = "git::https://github.com/Srikanthkovuri/Terraform-modules.git//aws/autoscalelb"
  ami_info = {
    id       = var.ami_info
    username = "ubuntu"
  }
  template_details = {
    name                        = var.ec2_info.name
    instance_type               = var.ec2_info.instance_type
    key_name                    = var.ec2_info.key_name
    script_path                 = "css-template.sh"
    security_group_ids          = [module.websg.id]
    associate_public_ip_address = true
  }
  scaling_details = {
    min_size   = 1
    max_size   = 2
    subnet_ids = [module.vpc.public_subnet_ids[0],module.vpc.public_subnet_ids[1]]
  }
  lb_details = {
    type               = "application"
    internal           = false
    security_group_ids = [module.lbsg[0].id]
    subnet_ids         = [module.vpc.public_subnet_ids[0],module.vpc.private_subnet_ids[1]]
    vpc_id             = module.vpc.id
    application_port   = 80
    port               = 80

  }


}

