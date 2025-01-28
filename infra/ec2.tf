resource "aws_instance" "extrato_lancamento_msk_ec2_client" {
  ami           = var.latest_ami_id
  instance_type = var.instance_type_ec2
  subnet_id     = aws_subnet.extrato_lancamento_public_subnet_1.id
  security_groups = [
    aws_security_group.extrato_lancamento_sg.id
  ]
  user_data = file("userdata.sh")
  tags      = local.custom_tags
}