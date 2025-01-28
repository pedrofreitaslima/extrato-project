#######################################################################################################################
#### Networking variables
#######################################################################################################################
output "extrato_lancamento_vpc_arn" {
  value       = aws_vpc.extrato_lancamento_vpc.arn
  description = "The ARN of the VPC dedicated to project Extrato Lancamento"
}

output "extrato_lancamento_internet_gateway_arn" {
  value       = aws_internet_gateway.extrato_lancamento_gw.id
  description = "The ID of the internet gateway dedicated to project Extrato Lancamento"
}

output "extrato_lancamento_public_subnet1_arn" {
  value       = aws_subnet.extrato_lancamento_public_subnet_1.arn
  description = "The ARN of the first public subnet in one availability zone dedicated to project Extrato Lancamento"
}

output "extrato_lancamento_public_subnet2_arn" {
  value       = aws_subnet.extrato_lancamento_public_subnet_2.arn
  description = "The ARN of the seconde public subnet in one availability zone dedicated to project Extrato Lancamento"
}

output "extrato_lancamento_public_subnet3_arn" {
  value       = aws_subnet.extrato_lancamento_public_subnet_3.arn
  description = "The ARN of the third public subnet in one availability zone dedicated to project Extrato Lancamento"
}

output "extrato_lancamento_private_subnet1_arn" {
  value       = aws_subnet.extrato_lancamento_private_subnet_1.arn
  description = "The ARN of the first private subnet in one availability zone dedicated to project Extrato Lancamento"
}

output "extrato_lancamento_private_subnet2_arn" {
  value       = aws_subnet.extrato_lancamento_private_subnet_2.arn
  description = "The ARN of the second private subnet in one availability zone dedicated to project Extrato Lancamento"
}

output "extrato_lancamento_private_subnet3_arn" {
  value       = aws_subnet.extrato_lancamento_private_subnet_3.arn
  description = "The ARN of the third private subnet in one availability zone dedicated to project Extrato Lancamento"
}

output "extrato_lancamento_public_route_table" {
  value       = aws_route_table.extrato_lancamento_public_route_table.arn
  description = "The ARN of the public route table dedicated to project Extrato Lancamento"
}

output "extrato_lancamento_public_route" {
  value       = aws_route.extrato_lancamento_public_route.id
  description = "The ID of the public route dedicated to project Extrato Lancamento"
}

output "extrato_lancamento_private_route_table_1" {
  value       = aws_route_table.extrato_lancamento_private_route_table_1.arn
  description = "The ARN of the first private route table dedicated to project Extrato Lancamento"
}

output "extrato_lancamento_private_route_table_2" {
  value       = aws_route_table.extrato_lancamento_private_route_table_2.arn
  description = "The ARN of the second private route table dedicated to project Extrato Lancamento"
}

output "extrato_lancamento_private_route_table_3" {
  value       = aws_route_table.extrato_lancamento_private_route_table_3.arn
  description = "The ARN of the third private route table dedicated to project Extrato Lancamento"
}
