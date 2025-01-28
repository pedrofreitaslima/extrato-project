output "extrato_lancamento_vpc_arn" {
  value       = aws_vpc.extrato_lancamento_vpc.arn
  description = "The ARN of the VPC dedicated to project Extrato Lancamento"
}