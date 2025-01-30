#######################################################################################################################
#### Networking
#######################################################################################################################
output "extrato_lancamento_vpc_arn" {
  value       = aws_vpc.extrato_lancamento_vpc.arn
  description = "The ARN of the VPC dedicated to project Extrato Lancamento"
}

output "extrato_lancamentoaws_vpc_endpoint_arn" {
  value       = aws_vpc_endpoint.extrato_lancamento_vpc_endpoint_s3.arn
  description = "The ARN of the VPC Enpoint to S3 dedicated to project Extrato Lancamento"
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

output "extrato_lancamento_security_group" {
  value       = aws_security_group.extrato_lancamento_sg.arn
  description = "The ARN of the security group dedicated to project Extrato Lancamento"
}

output "extrato_lancamento_sg_ingress_all_arn" {
  value       = aws_vpc_security_group_ingress_rule.extrato_lancamento_sg_ingress_all.arn
  description = "The ARN of the security group ingress rule for all  dedicated to project Extrato Lancamento"
}

output "extrato_lancamento_sg_egress_all_arn" {
  value       = aws_vpc_security_group_egress_rule.extrato_lancamento_sg_egress_all.arn
  description = "The ARN of the security group egress rule for all dedicated to project Extrato Lancamento"
}

#######################################################################################################################
#### Security
#######################################################################################################################
output "extrato_lancamento_glue_iam_role_arn" {
  value       = aws_iam_role.extrato_lancamento_glue_role.arn
  description = "The ARN of the IAM role to glue dedicated to project Extrato Lancamento"
}

output "extrato_lancamento_glue_iam_policy_arn" {
  value       = aws_iam_policy.extrato_lancamento_glue_policy.arn
  description = "The ARN of the IAM role to glue dedicated to project Extrato Lancamento"
}

output "extrato_lancamento_lambda_msk_produce_iam_role_arn" {
  value       = aws_iam_role.extrato_lancamento_lambda_msk_producer_role.arn
  description = "The ARN of the IAM role to lambda dedicated to project Extrato Lancamento"
}

output "extrato_lancamento_lambda_msk_produce_iam_policy_arn" {
  value       = aws_iam_policy.extrato_lancamento_lambda_msk_producer_policy.arn
  description = "The ARN of the IAM policy to lambda dedicated to project Extrato Lancamento"
}

output "extrato_lancamento_lambda_msk_getbroker_iam_role_arn" {
  value = aws_iam_role.extrato_lancamento_glue_msk_getbroker_role.arn
  description = "The ARN of the IAM role to glue dedicated to project Extrato Lancamento"
}

output "extrato_lancamento_lambda_msk_getbroke_iam_policy_arn" {
  value = aws_iam_policy.extrato_lancamento_lambda_msk_getbroker_policy.arn
  description = "The ARN of the IAM policy to lambda dedicated to project Extrato Lancamento"
}

output "extrato_lancamento_lambda_cleanup_iam_role_arn" {
  value = aws_iam_role.extrato_lancamento_lambda_cleanup_role.arn
  description = "The ARN of the IAM role to lambda dedicated to project Extrato Lancamento"
}

output "extrato_lancamento_lambda_cleanup_iam_policy_arn" {
  value = aws_iam_policy.extrato_lancamento_lambda_cleanup_policy.arn
  description = "The ARN of the IAM policy to lambda dedicated to project Extrato Lancamento"
}

#######################################################################################################################
#### Storage
#######################################################################################################################
output "extrato_lancamento_s3_bucket_input_glue_arn" {
  value       = aws_s3_bucket.extrato_lancamento_input_glue_bucket.arn
  description = "The ARN of the S3 bucket dedicated to project Extrato Lancamento for glue input"
}

output "extrato_lancamento_s3_bucket_output_glue_arn" {
  value       = aws_s3_bucket.extrato_lancamento_output_glue_bucket.arn
  description = "The ARN of the S3 bucket dedicated to project Extrato Lancamento for glue output"
}

#######################################################################################################################
#### MSK
#######################################################################################################################
output "extrato_lancamento_msk_serverless_cluster_arn" {
  value       = aws_msk_serverless_cluster.extrato_lancamento_msk_serverless_cluster.arn
  description = "The ARN of the MSK serverless cluster dedicated to project Extrato Lancamento"
}

#######################################################################################################################
#### Glue
#######################################################################################################################
output "extrato_lancamento_glue_registry_arn" {
  value       = aws_glue_registry.extrato_lancamento_glue_registry.arn
  description = "The ARN of the Glue registry dedicated to project Extrato Lancamento"
}

output "extrato_lancamento_glue_schema_avro_arn" {
  value       = aws_glue_schema.extrato_lancamento_glue_schema_avro.arn
  description = "The ARN of the Glue schema with AVRO format dedicated to project Extrato Lancamento"
}

output "extrato_lancamento_glue_schema_json_arn" {
  value       = aws_glue_schema.extrato_lancamento_glue_schema_json.arn
  description = "The ARN of the Glue schema with JSON format dedicated to project Extrato Lancamento"
}

output "extrato_lancamento_glue_catalog_database_arn" {
  value       = aws_glue_catalog_database.extrato_lancamento_glue_catalog_database.arn
  description = "The ARN of the Glue catalog database dedicated to project Extrato Lancamento"
}

output "extrato_lancamento_glue_catalog_table_arn" {
  value       = aws_glue_catalog_table.extrato_lancamento_glue_catalog_table.arn
  description = "The ARN of the Glue catalog table dedicated to project Extrato Lancamento"
}

output "extrato_lancamento_glue_connection_arn" {
  value       = aws_glue_connection.extrato_lancamento_glue_connection.arn
  description = "The ARN of the Glue connection with MSK Kafka dedicated to project Extrato Lancamento"
}

output "extrato_lancamento_glue_job_arn" {
  value       = aws_glue_job.extrato_lancamento_glue_job.arn
  description = "The ARN of the Glue Job dedicated to project Extrato Lancamento"
}

#######################################################################################################################
#### Observability
#######################################################################################################################
output "extrato_lancamento_glue_job_cloudwatch_log_group_arn" {
  value       = aws_cloudwatch_log_group.extrato_lancamento_glue_job_log_group.arn
  description = "The ARN of the Cloudwatch log group for glue job dedicated to project Extrato Lancamento"
}

#######################################################################################################################
#### OpenSearch
#######################################################################################################################
