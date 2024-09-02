output "instance_public_ips" {
  value = {
    for key, value in aws_instance.server : key => value.public_ip
  }
}
output "instance_private_ips" {
  value = {
    for key, v in aws_instance.server : key => value.private_ip
  }
}