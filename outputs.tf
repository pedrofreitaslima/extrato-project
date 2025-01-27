output "aws_glue_registry_lancamento_arn" {
  value       = aws_glue_registry.lancamento_registry.arn
  description = "The ARN of the Glue Registry for the Lancamento"
}

output "aws_glue_schema_lancamento_arn" {
  value       = aws_glue_schema.lancamento_schema_avro.arn
  description = "The ARN of the Schema of Glue Registry for the Lancamento"
}
