#######################################################################################################################
#### CloudWatch Log Group
#######################################################################################################################
resource "aws_cloudwatch_log_group" "extrato_lancamento_glue_job_log_group" {
  name              = "${local.domain_name}-glue-job"
  retention_in_days = var.retention_period
  tags              = local.custom_tags
}