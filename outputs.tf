
output "ec2instance" {
  value = aws_instance.bincom_iac_instance.public_ip
}
