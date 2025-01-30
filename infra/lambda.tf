#######################################################################################################################
#### Lambda GetBootstrap Brokers
#######################################################################################################################
data "archive_file" "zip_the_python_code_getbroker" {
  type        = "zip"
  source_dir  = "${path.module}/../app/lambda_bootstrap/"
  output_path = "${path.module}/lambda_function_getbroker.zip"
}

resource "aws_lambda_function" "extrato_lancamento_msk_bootstrap_brokers_function" {
  filename         = data.archive_file.zip_the_python_code_getbroker.output_path
  function_name    = "${local.domain_name}-msk-bootstrap-brokers"
  role             = aws_iam_role.extrato_lancamento_lambda_msk_getbroker_role.arn
  handler          = "lambda_function.lambda_handler"
  source_code_hash = data.archive_file.zip_the_python_code_getbroker.output_base64sha256
  runtime          = "python3.11"
  timeout          = 30
  tags             = local.custom_tags
}

resource "aws_lambda_invocation" "extrato_lancamento_bootstrap_brokers_invocation" {
  function_name = aws_lambda_function.extrato_lancamento_msk_bootstrap_brokers_function.function_name

  input = jsonencode({
    ClusterArn                = aws_msk_serverless_cluster.extrato_lancamento_msk_serverless_cluster.arn
    privateSubnetId           = aws_subnet.extrato_lancamento_private_subnet_1.id
    S3BucketForGlueScriptCopy = aws_s3_bucket.extrato_lancamento_input_glue_bucket.bucket
  })

  lifecycle {
    create_before_destroy = true
  }
}

output "extrato_lancamento_msk_bootstrap_brokers_function_result" {
  value = jsondecode(aws_lambda_invocation.extrato_lancamento_bootstrap_brokers_invocation.result)
}

# #######################################################################################################################
# #### Lambda CleanUp Buckets
# #######################################################################################################################
data "archive_file" "zip_the_python_code_cleanup" {
  type        = "zip"
  source_dir  = "${path.module}/../app/lambda_cleanup/"
  output_path = "${path.module}/lambda_function_cleanup.zip"
}

resource "aws_lambda_function" "extrato_lancamento_msk_cleanup_function" {
  filename         = data.archive_file.zip_the_python_code_cleanup.output_path
  function_name    = "${local.domain_name}-msk-cleanup-s3bucket-iamrole"
  role             = aws_iam_role.extrato_lancamento_lambda_cleanup_role.arn
  handler          = "lambda_function.lambda_handler"
  source_code_hash = data.archive_file.zip_the_python_code_cleanup.output_base64sha256
  runtime          = "python3.11"
  timeout          = 30
  tags             = local.custom_tags
}

resource "aws_lambda_invocation" "extrato_lancamento_cleanup_getbroket_invocation" {
  function_name   = aws_lambda_function.extrato_lancamento_msk_bootstrap_brokers_function.function_name
  lifecycle_scope = "CRUD"
  input = jsonencode({
    "IamRole"    = aws_iam_role.extrato_lancamento_lambda_msk_getbroker_role.name
    "BucketName" = aws_s3_bucket.extrato_lancamento_input_glue_bucket.bucket
    "tf" = {
      "action" = "delete"
      "prev_input" = {
        "IamRole"    = aws_iam_role.extrato_lancamento_lambda_msk_getbroker_role.name
        "BucketName" = aws_s3_bucket.extrato_lancamento_input_glue_bucket.bucket
      }
    }
  })
}

output "extrato_lancamento_msk_cleanup_getbroker_output_function_result" {
  value = jsondecode(aws_lambda_invocation.extrato_lancamento_cleanup_getbroket_invocation.result)
}

resource "aws_lambda_invocation" "extrato_lancamento_cleanup_output_invocation" {
  function_name   = aws_lambda_function.extrato_lancamento_msk_bootstrap_brokers_function.function_name
  lifecycle_scope = "CRUD"

  input = jsonencode({
    "IamRole"    = aws_iam_role.extrato_lancamento_lambda_cleanup_role.name
    "BucketName" = aws_s3_bucket.extrato_lancamento_output_glue_bucket.bucket
    "tf" = {
      "action" = "delete"
      "prev_input" = {
        "IamRole"    = aws_iam_role.extrato_lancamento_lambda_cleanup_role.name
        "BucketName" = aws_s3_bucket.extrato_lancamento_output_glue_bucket.bucket
      }
    }
  })
}

output "extrato_lancamento_msk_cleanup_output_function_result" {
  value = jsondecode(aws_lambda_invocation.extrato_lancamento_cleanup_output_invocation.result)
}


# #######################################################################################################################
# #### Lambda Producer Event Kafka
# #######################################################################################################################
data "archive_file" "zip_the_python_code_producer_kafka" {
  type        = "zip"
  source_dir  = "${path.module}/../app/lambda_producer_kafka/"
  output_path = "${path.module}/lambda_function_producer_kafka.zip"
}

resource "aws_lambda_function" "extrato_lancamento_msk_producer_kafka_function" {
  filename         = data.archive_file.zip_the_python_code_producer_kafka.output_path
  function_name    = "${local.domain_name}-msk-producer-kafka"
  role             = aws_iam_role.extrato_lancamento_lambda_msk_producer_role.arn
  handler          = "lambda_function.lambda_handler"
  source_code_hash = data.archive_file.zip_the_python_code_cleanup.output_base64sha256
  runtime          = "python3.11"
  timeout          = 30
  tags             = local.custom_tags

  logging_config {
    log_format = ""
  }

  environment {

    variables = {
      "BOOTSTRAP_SERVERS" = "",
      "KAFKA_TOPIC"       = "${local.domain_name}-topic"
    }
  }
}