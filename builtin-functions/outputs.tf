output "instance_public_ips" {
  value = aws_instance.ec2.*.public_ip
}

output "instance_names" {
  value = join(", ", aws_instance.ec2.*.tags.name)
}