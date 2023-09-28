
output "ec2instance" {
  value = aws_instance.iac_instance.public_ip
}
