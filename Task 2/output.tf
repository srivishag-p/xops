output "ec2_public_ip" {
  value = aws_instance.xops_ec2.public_ip
}
