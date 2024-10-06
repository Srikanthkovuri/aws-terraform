vpc_info = {
  cidr_block = "192.168.0.0/16"
}
public_subnets = [{
  cidr_block = "192.168.0.0/24"
  available_region        = "ap-south-1a"
  tags = {
    "name" = "web-1"
  }
  },
  {
    cidr_block = "192.168.1.0/24"
    available_region        = "ap-south-1b"
    tags = {
      "name" = "web-2"
    }
}]
private_subnets = [{
  cidr_block = "192.168.2.0/24"
  available_region        = "ap-south-1a"
  tags = {
    "name" = "db-1"
  }
  },
  {
    cidr_block = "192.168.3.0/24"
    available_region       = "ap-south-1b"
    tags = {
      "name" = "db-2"
    }

}]
web_security_group_info = [{
  from_port   = 22
  to_port     = 22
  ip_protocol = "tcp"
  cidr_ipv4 = "0.0.0.0/0"
  },
  {
    from_port   = 5000
    to_port     = 5000
    ip_protocol = "tcp"
    cidr_ipv4 = "0.0.0.0/0"
}]
db_security_group_info = [{
  from_port   = 3306
  to_port     = 3306
  ip_protocol = "tcp"
  cidr_ipv4 = "192.168.0.0/16"
}]
lb_security_group_info = [{
  from_port   = 80
  to_port     = 80
  ip_protocol = "tcp"
  cidr_ipv4 = "0.0.0.0/0"
}]
ec2_info = {
  ami           = "ami-0dee22c13ea7a9a67"
  key_name      = "my_pub_rsa"
  name          = "tf-ec2"
  instance_type = "t2.micro"
}