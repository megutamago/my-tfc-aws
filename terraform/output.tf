output "public_ip" {
  value = aws_eip.bar.public_ip
}

output "ssh_command" {
  value = "ssh -i deployer-key.pem ubuntu@${aws_eip.bar.public_ip}"
}