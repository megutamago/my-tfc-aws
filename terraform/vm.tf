resource "aws_network_interface" "foo" {
  subnet_id   = aws_subnet.my_subnet.id
  private_ips = ["172.16.10.100"]
  security_groups = [aws_security_group.allow_test.id]

  tags = {
    Name = "tf-example"
  }
}

resource "aws_instance" "foo" {
  ami           = data.aws_ami.ubuntu-jammy-ami.id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.deployer.id

  network_interface {
    network_interface_id = aws_network_interface.foo.id
    device_index         = 0
  }

  tags = {
    Name = "tf-example"
  }
}

resource "aws_eip" "bar" {
  instance                  = aws_instance.foo.id
  associate_with_private_ip = "172.16.10.100"
  depends_on                = [aws_internet_gateway.gw]
}