resource "aws_vpc" "extrato_lancamento_vpc" {
  cidr_block       = "192.168.0.0/22"
  tags = var.custom_tags
}