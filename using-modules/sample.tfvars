vpc_info = [{
  cidr_block = "192.168.0.0/16"
  name = "vpc-using-modules"
}]
public_subnets = [ {
  cidr_block = "192.168.0.0/24"
  azs = "ap-south-1a"
},
{
  cidr_block = "192.168.1.0/24"
  azs = "ap-south-1b"
}]
private_subnets = [ {
    cidr_block = "192.168.2.0/24"
  azs = "ap-south-1a"
},
{
  cidr_block = "192.168.3.0/24"
  azs = "ap-south-1b"
  
} ]
security_group_info = [ {
  from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
},
{
    from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
} ]
ec2_info = {
  ami = "ami-0dee22c13ea7a9a67"
  key_name = "my_pub_rsa"
  name = "tf-ec2"
  instance_type = "t2.micro"
}