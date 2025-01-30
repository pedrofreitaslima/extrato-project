#######################################################################################################################
#### IAM Roles
#######################################################################################################################
resource "aws_iam_role" "extrato_lancamento_glue_role" {
  name               = "${local.domain_name}-glue-role"
  assume_role_policy = data.aws_iam_policy_document.extrato_lancamento_assume_role_glue.json
  tags               = local.custom_tags
}

resource "aws_iam_role" "extrato_lancamento_lambda_msk_producer_role" {
  name               = "${local.domain_name}-lambda-msk-producer"
  assume_role_policy = data.aws_iam_policy_document.extrato_lancamento_assume_role_lambda.json
  tags               = local.custom_tags
}

resource "aws_iam_role" "extrato_lancamento_lambda_cleanup_role" {
  name               = "${local.domain_name}-lambda-cleanup-role"
  assume_role_policy = data.aws_iam_policy_document.extrato_lancamento_assume_role_lambda.json
  tags               = local.custom_tags
}

resource "aws_iam_role" "extrato_lancamento_lambda_msk_getbroker_role" {
  name               = "${local.domain_name}-lambda-msk-getbroker-role"
  assume_role_policy = data.aws_iam_policy_document.extrato_lancamento_assume_role_lambda.json
  tags               = local.custom_tags
}

#######################################################################################################################
#### IAM Policy Documents
#######################################################################################################################
data "aws_iam_policy_document" "extrato_lancamento_assume_role_glue" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["glue.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "extrato_lancamento_assume_role_lambda" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "extrato_lancamento_glue_policy_document" {
  statement {
    sid = "AllowKafkaCluster"
    actions = [
      "kafka-cluster:Connect",
      "kafka-cluster:AlterCluster",
      "kafka-cluster:DescribeCluster"
    ]
    effect = "Allow"
    resources = [
      "arn:aws:kafka:${data.aws_region.current.id}:${data.aws_caller_identity.current.account_id}:cluster/*/*"
    ]
  }

  statement {
    sid = "AllowKafkaTopic"
    actions = [
      "kafka-cluster:CreateTopic",
      "kafka-cluster:DescribeTopic",
      "kafka-cluster:WriteData",
      "kafka-cluster:ReadData"
    ]
    effect = "Allow"
    resources = [
      "arn:aws:kafka:${data.aws_region.current.id}:${data.aws_caller_identity.current.account_id}:topic/*/*/*"
    ]
  }

  statement {
    sid = "AllowKafkaGroup"
    actions = [
      "kafka-cluster:AlterGroup",
      "kafka-cluster:DescribeGroup"
    ]
    effect = "Allow"
    resources = [
      "arn:aws:kafka:${data.aws_region.current.id}:${data.aws_caller_identity.current.account_id}:group/*/*/*"
    ]
  }

  statement {
    sid = "AllowS3Output"
    actions = [
      "s3:PutObject*",
      "s3:ListBucket",
      "s3:GetObject*",
      "s3:DeleteObject*"
    ]
    effect = "Allow"
    resources = [
      aws_s3_bucket.extrato_lancamento_input_glue_bucket.arn,
      aws_s3_bucket.extrato_lancamento_output_glue_bucket.arn,
      "${aws_s3_bucket.extrato_lancamento_output_glue_bucket.arn}/*",
      "${aws_s3_bucket.extrato_lancamento_input_glue_bucket.arn}/*"
    ]
  }
}

data "aws_iam_policy_document" "extrato_lancamento_lambda_msk_producer_policy_document" {
  statement {
    sid = "AllowReadWriteAccessMSKCluster"
    actions = [
      "kafka-cluster:Connect",
      "kafka-cluster:AlterCluster",
      "kafka-cluster:DescribeCluster"
    ]
    effect = "Allow"
    resources = [
      aws_msk_serverless_cluster.extrato_lancamento_msk_serverless_cluster.arn
    ]
  }

  statement {
    sid = "AllowReadWriteAccessMSKClusterTopic"
    actions = [
      "kafka-cluster:CreateTopic",
      "kafka-cluster:DescribeTopic",
      "kafka-cluster:WriteData",
      "kafka-cluster:ReadData"
    ]
    effect = "Allow"
    resources = [
      "arn:aws:kafka:${data.aws_region.current.id}:${data.aws_caller_identity.current.account_id}:topic/${local.domain_name}/*/*"
    ]
  }

  statement {
    sid = "AllowReadWriteAccessMSKClusterGroup"
    actions = [
      "kafka-cluster:AlterGroup",
      "kafka-cluster:DescribeGroup"
    ]
    effect = "Allow"
    resources = [
      "arn:aws:kafka:${data.aws_region.current.id}:${data.aws_caller_identity.current.account_id}:group/${local.domain_name}/*/*"
    ]
  }

  statement {
    sid = "AllowMSKS3"
    actions = [
      "s3:Get*",
      "s3:PutObject*",
      "s3:List*"
    ]
    effect = "Allow"
    resources = [
      aws_s3_bucket.extrato_lancamento_input_glue_bucket.arn,
      "${aws_s3_bucket.extrato_lancamento_input_glue_bucket.arn}/*",
      aws_s3_bucket.extrato_lancamento_output_glue_bucket.arn,
      "${aws_s3_bucket.extrato_lancamento_output_glue_bucket.arn}/*"
    ]
  }
}

data "aws_iam_policy_document" "extrato_lancamento_lambda_msk_getbroker_policy_document" {
  statement {
    sid = "AllowGetBootstrapBrokers"
    actions = [
      "kafka:GetBootstrapBrokers",
      "kafka:DescribeCluster"
    ]
    effect = "Allow"
    resources = [
      aws_msk_serverless_cluster.extrato_lancamento_msk_serverless_cluster.arn
    ]
  }

  statement {
    sid = "AllowObservability"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    effect    = "Allow"
    resources = ["arn:aws:logs:${data.aws_region.current.id}:${data.aws_caller_identity.current.account_id}:*"]
  }

  statement {
    sid = "AllowMSKS3"
    actions = [
      "s3:GetObject",
      "s3:PutObject"
    ]
    effect = "Allow"
    resources = [
      aws_s3_bucket.extrato_lancamento_input_glue_bucket.arn,
      "${aws_s3_bucket.extrato_lancamento_input_glue_bucket.arn}/*"
    ]
  }
}

data "aws_iam_policy_document" "extrato_lancamento_glue_msk_secleanup_policy_document" {
  statement {
    sid = "AllowAttachRolePolicy"
    actions = [
      "iam:ListAttachedRolePolicies",
      "iam:DetachRolePolicy"
    ]
    effect = "Allow"
    resources = [
      aws_iam_role.extrato_lancamento_lambda_msk_getbroker_role.arn,
      aws_iam_role.extrato_lancamento_lambda_cleanup_role.arn,
      aws_iam_role.extrato_lancamento_glue_role.arn,
      aws_iam_role.extrato_lancamento_lambda_msk_producer_role.arn
    ]
  }

  statement {
    sid = "AllowMSKS3"
    actions = [
      "s3:Get*",
      "s3:PutObject*",
      "s3:List*"
    ]
    effect = "Allow"
    resources = [
      aws_s3_bucket.extrato_lancamento_input_glue_bucket.arn,
      "${aws_s3_bucket.extrato_lancamento_input_glue_bucket.arn}/*",
      aws_s3_bucket.extrato_lancamento_output_glue_bucket.arn,
      "${aws_s3_bucket.extrato_lancamento_output_glue_bucket.arn}/*"
    ]
  }
}

#######################################################################################################################
#### IAM Policy
#######################################################################################################################
resource "aws_iam_policy" "extrato_lancamento_glue_policy" {
  name        = "${local.domain_name}-glue-policy"
  description = "This policy used in ${local.domain_name} with permissions needed."
  policy      = data.aws_iam_policy_document.extrato_lancamento_glue_policy_document.json
}

resource "aws_iam_policy" "extrato_lancamento_lambda_msk_producer_policy" {
  name        = "${local.domain_name}-lambda-msk-producer-policy"
  description = "This policy used in ${local.domain_name} with permissions needed."
  policy      = data.aws_iam_policy_document.extrato_lancamento_lambda_msk_producer_policy_document.json
}

resource "aws_iam_policy" "extrato_lancamento_lambda_cleanup_policy" {
  name        = "${local.domain_name}-lambda-cleanup-policy"
  description = "This policy used in ${local.domain_name} with permissions needed."
  policy      = data.aws_iam_policy_document.extrato_lancamento_glue_msk_secleanup_policy_document.json
}

resource "aws_iam_policy" "extrato_lancamento_lambda_msk_getbroker_policy" {
  name        = "${local.domain_name}-lambda-msk-getbroker-policy"
  description = "This policy used in ${local.domain_name} with permissions needed."
  policy      = data.aws_iam_policy_document.extrato_lancamento_lambda_msk_getbroker_policy_document.json
}

#######################################################################################################################
#### Role Policy Attachments
#######################################################################################################################
resource "aws_iam_role_policy_attachment" "extrato_lancamento_aws_glue_service_role_policy_attachment" {
  role       = aws_iam_role.extrato_lancamento_glue_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}

resource "aws_iam_role_policy_attachment" "extrato_lancamento_glue_role_policy_attachment" {
  role       = aws_iam_role.extrato_lancamento_glue_role.name
  policy_arn = aws_iam_policy.extrato_lancamento_glue_policy.arn
}

resource "aws_iam_role_policy_attachment" "extrato_lancamento_lambda_msk_producer_lambda_basic_execution_role_policy_attachment" {
  role       = aws_iam_role.extrato_lancamento_lambda_msk_producer_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "extrato_lancamento_lambda_msk_producer_role_policy_attachment" {
  role       = aws_iam_role.extrato_lancamento_lambda_msk_producer_role.name
  policy_arn = aws_iam_policy.extrato_lancamento_lambda_msk_producer_policy.arn
}

resource "aws_iam_role_policy_attachment" "extrato_lancamento_lambda_msk_getbroker_lambda_basic_execution_role_policy_attachment" {
  role       = aws_iam_role.extrato_lancamento_lambda_msk_getbroker_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "extrato_lancamento_lambda_msk_getbroker_role_policy_attachment" {
  role       = aws_iam_role.extrato_lancamento_lambda_msk_getbroker_role.name
  policy_arn = aws_iam_policy.extrato_lancamento_lambda_msk_getbroker_policy.arn
}

resource "aws_iam_role_policy_attachment" "extrato_lancamento_lambda_cleanup_lambda_basic_execution_role_policy_attachment" {
  role       = aws_iam_role.extrato_lancamento_lambda_cleanup_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "extrato_lancamento_lambda_cleanup_role_policy_attachment" {
  role       = aws_iam_role.extrato_lancamento_lambda_cleanup_role.name
  policy_arn = aws_iam_policy.extrato_lancamento_lambda_cleanup_policy.arn
}
