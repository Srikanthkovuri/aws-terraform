output "public_ip" {
  value = module.ec2_instance.public_ip
  description = "It displays public ip of instance"
}
output "instance_id" {
  value = module.ec2_instance.id
  description = "It displays instance id"
}
output "oxer" {
  value = "http://${module.ec2_instance.public_ip}/oxer"
  description = "It is the url of sample application"
}