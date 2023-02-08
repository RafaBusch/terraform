output "extensions" {
  value = local.file_extensions
}

output "instance-arns" {
  value = [for ke, valu in aws_instance.this : valu.arn]
}

output "instance_names" {
  value = { for ke, valu in aws_instance.this : ke => valu.tags.Name }
}

output "extensions_upper" {
  value = local.file_extensions_upper
}

output "private_ips" {
  value = [for o in local.ips : o.private]
}

output "public_ips" {
  value = local.ips[*].public
}