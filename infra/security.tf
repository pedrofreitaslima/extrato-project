#######################################################################################################################
#### IAM Roles
#######################################################################################################################
resource "aws_iam_role" "extrato_lancamento_msk_ec2client_role" {
  name               = "${local.domain_name}-msk-ec2client-role"
  assume_role_policy = data.aws_iam_policy_document.extrato_lancamento_assume_role_ec2.json
  tags               = local.custom_tags
}

resource "aws_iam_role" "extrato_lancamento_glue_msk_secleanup_role" {
  name               = "${local.domain_name}-glue-msk-secleanup-role"
  assume_role_policy = data.aws_iam_policy_document.extrato_lancamento_assume_role_lambda.json
  tags               = local.custom_tags
}

resource "aws_iam_role" "extrato_lancamento_glue_msk_getbroker_role" {
  name               = "${local.domain_name}-glue-msk-getbroker-role"
  assume_role_policy = data.aws_iam_policy_document.extrato_lancamento_assume_role_lambda.json
  tags               = local.custom_tags
}

#######################################################################################################################
#### IAM Policy Documents
#######################################################################################################################
data "aws_iam_policy_document" "extrato_lancamento_assume_role_ec2" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
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

data "aws_iam_policy_document" "extrato_lancamento_msk_ec2client_policy_document" {
  statement {
    sid = "AllowReadWriteAccessMSKCluster"
    actions = [
      "kafka-cluster:Connect",
      "kafka-cluster:AlterCluster",
      "kafka-cluster:DescribeCluster"
    ]
    effect = "Allow"
    resources = [
      "*" # TODO: Alter to cluster MSK serverless ARN
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
      "*" # TODO: Alter to add S3 bucket ARN
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
      aws_iam_role.extrato_lancamento_msk_ec2client_role.arn
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
      "*" # TODO: Alter to add S3 bucket ARN
    ]
  }
}

data "aws_iam_policy_document" "extrato_lancamento_glue_msk_getbroker_policy_document" {
  statement {
    sid = "AllowGetBootstrapBrokers"
    actions = [
      "kafka:GetBootstrapBrokers"
    ]
    effect = "Allow"
    resources = [
      "*" # TODO: Alter to cluster MSK serverless ARN
    ]
  }

  statement {
    sid = "AllowDescribeSubnets"
    actions = [
      "ec2:DescribeSubnets"
    ]
    effect = "Allow"
    resources = "*"
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
      "*" # TODO: Alter to add S3 bucket ARN
    ]
  }
}

#######################################################################################################################
#### IAM Policy
#######################################################################################################################
resource "aws_iam_policy" "extrato_lancamento_msk_ec2client_policy" {
  name        = "${local.domain_name}-msk-ec2client-policy"
  description = "This policy used in ${local.domain_name} with permissions needed."
  policy      = data.aws_iam_policy_document.extrato_lancamento_msk_ec2client_policy_document.json
}

resource "aws_iam_policy" "extrato_lancamento_glue_msk_secleanup_policy" {
  name        = "${local.domain_name}-glue-msk-secleanup-policy"
  description = "This policy used in ${local.domain_name} with permissions needed."
  policy      = data.aws_iam_policy_document.extrato_lancamento_glue_msk_secleanup_policy_document.json
}

resource "aws_iam_policy" "extrato_lancamento_glue_msk_getbroker_policy" {
  name        = "${local.domain_name}-glue-msk-getbroker-policy"
  description = "This policy used in ${local.domain_name} with permissions needed."
  policy      = data.aws_iam_policy_document.extrato_lancamento_glue_msk_getbroker_policy_document.json
}

#######################################################################################################################
#### Role Policy Attachments
#######################################################################################################################
resource "aws_iam_role_policy_attachment" "extrato_lancamento_ssm_full_access_role_policy_attachment" {
  role       = aws_iam_role.extrato_lancamento_msk_ec2client_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
}

resource "aws_iam_role_policy_attachment" "extrato_lancamento_lambda_basic_execution_role_policy_attachment" {
  role       = aws_iam_role.extrato_lancamento_glue_msk_secleanup_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "extrato_lancamento_lambda_basic_execution_role_policy_attachment" {
  role       = aws_iam_role.extrato_lancamento_glue_msk_secleanup_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "extrato_lancamento_msk_ec2client_policy_attach" {
  role       = aws_iam_role.extrato_lancamento_glue_msk_getbroker_role.name
  policy_arn = aws_iam_policy.extrato_lancamento_msk_ec2client_policy.arn
}

resource "aws_iam_role_policy_attachment" "extrato_lancamento_glue_msk_secleanup_policy_attach" {
  role       = aws_iam_role.extrato_lancamento_glue_msk_secleanup_role.name
  policy_arn = aws_iam_policy.extrato_lancamento_glue_msk_secleanup_policy.arn
}

resource "aws_iam_role_policy_attachment" "extrato_lancamento_glue_msk_secleanup_policy_attach" {
  role       = aws_iam_role.extrato_lancamento_glue_msk_getbroker_role.name
  policy_arn = aws_iam_policy.extrato_lancamento_glue_msk_getbroker_policy.arn
}
