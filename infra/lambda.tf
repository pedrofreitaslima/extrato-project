data "archive_file" "zip_the_python_code" {
  type        = "zip"
  source_dir  = "${path.module}/../app/lambda_bootstrap/"
  output_path = "lambda_function_payload.zip"
}

resource "aws_lambda_function" "extrato_lancamento_msk_bootstrap_brokers_function" {
  filename      = "lambda_function_payload.zip"
  function_name = "${local.domain_name}-msk-bootstrap-brokers"
  role          = aws_iam_role.extrato_lancamento_glue_msk_getbroker_role.arn
  handler       = "index.lambda_handler"
  runtime       = "python3.10"
  timeout       = 30
  tags          = local.custom_tags
}