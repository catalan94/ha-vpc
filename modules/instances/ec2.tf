# Public
resource "aws_instance" "ec2-public" {
  count = length(var.public_subnets)
  ami = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  subnet_id = element(var.public_subnets.*.id, count.index)
  vpc_security_group_ids = [aws_security_group.public_sg.id]
  associate_public_ip_address = true
  key_name = aws_key_pair.key_access.key_name

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "EC2 PUB - ${count.index + 1}"
  }

}
  

# Private
resource "aws_instance" "ec2-private" {
  count = length(var.private_subnets)
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  subnet_id = element(var.private_subnets.*.id, count.index)
  vpc_security_group_ids = [aws_security_group.private_sg.id]
  key_name = aws_key_pair.key_access.key_name

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "EC2 PVT - ${count.index + 1}"
  }

}