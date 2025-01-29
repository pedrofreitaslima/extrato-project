data "archive_file" "zip_the_python_code" {
  type        = "zip"
  source_dir  = "${path.module}/../app/lambda_bootstrap/"
  output_path = "${path.module}/lambda_function_payload.zip"
}

resource "aws_lambda_function" "extrato_lancamento_msk_bootstrap_brokers_function" {
  filename         = data.archive_file.zip_the_python_code.output_path
  function_name    = "${local.domain_name}-msk-bootstrap-brokers"
  role             = aws_iam_role.extrato_lancamento_glue_msk_getbroker_role.arn
  handler          = "lambda_function.lambda_handler"
  source_code_hash = data.archive_file.zip_the_python_code.output_base64sha256
  runtime          = "python3.11"
  timeout          = 30
  tags             = local.custom_tags
}

resource "aws_lambda_invocation" "extrato_lancamento_bootstrap_brokers_invocation" {
  function_name = aws_lambda_function.extrato_lancamento_msk_bootstrap_brokers_function.function_name

  input = jsonencode({
    ClusterArn                = aws_msk_serverless_cluster.extrato_lancamento_msk_serverless_cluster.arn
    privateSubnetId           = aws_subnet.extrato_lancamento_private_subnet_1.id
    S3BucketForGlueScriptCopy = aws_s3_bucket.extrato_lancamento_gluescript_bucket.id
  })

  lifecycle {
    create_before_destroy = true
  }
}

output "extrato_lancamento_msk_bootstrap_brokers_function_result" {
  value = jsondecode(aws_lambda_invocation.extrato_lancamento_bootstrap_brokers_invocation.result)
}
