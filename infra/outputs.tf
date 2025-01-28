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
output "extrato_lancamento_msk_ec2client_role_arn" {
  value       = aws_iam_role.extrato_lancamento_msk_ec2client_role.arn
  description = "The ARN of the iam role dedicated to project Extrato Lancamento"
}

output "extrato_lancamento_glue_msk_secleanup_role_arn" {
  value       = aws_iam_role.extrato_lancamento_glue_msk_secleanup_role.arn
  description = "The ARN of the iam role dedicated to project Extrato Lancamento for s3 clean up"
}
output "extrato_lancamento_glue_msk_getbroker_role_arn" {
  value       = aws_iam_role.extrato_lancamento_glue_msk_getbroker_role.arn
  description = "The ARN of the iam role dedicated to project Extrato Lancamento for get broker msk"
}

#######################################################################################################################
#### S3 Buckets
#######################################################################################################################
output "extrato_lancamento_s3_bucket_glueoutput_arn" {
  value       = aws_s3_bucket.extrato_lancamento_glueoutput_bucket.arn
  description = "The ARN of the S3 bucket dedicated to project Extrato Lancamento for glue output"
}

output "extrato_lancamento_gluescript_bucket" {
  value       = aws_s3_bucket.extrato_lancamento_glueoutput_bucket.arn
  description = "The ARN of the S3 bucket dedicated to project Extrato Lancamento for glue script"
}

#######################################################################################################################
#### MSK Cluster
#######################################################################################################################
output "extrato_lancamento_msk_serverless_cluster_arn" {
  value       = aws_msk_serverless_cluster.extrato_lancamento_msk_serverless_cluster.arn
  description = "The ARN of the MSK serverless cluster dedicated to project Extrato Lancamento"
}

#######################################################################################################################
#### ECS instance for MSK Client
#######################################################################################################################
output "extrato_lancamento_msk_ec2_client_arn" {
  value       = aws_instance.extrato_lancamento_msk_ec2_client.arn
  description = "The ARN of the EC2 instance for MSK cliente dedicated to project Extrato Lancamento"
}