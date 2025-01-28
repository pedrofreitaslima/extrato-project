resource "aws_iam_role" "extrato_lancamento_msk_ec2client_role" {
  name               = "${local.domain_name}-msk-ec2client-role"
  assume_role_policy = data.aws_iam_policy_document.extrato_lancamento_assume_role_policy_document.json
  tags               = local.custom_tags
}

data "aws_iam_policy_document" "extrato_lancamento_assume_role_policy_document" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "extrato_lancamento_policy_document" {
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

resource "aws_iam_policy" "extrato_lancamento_msk_ec2client_policy" {
  name        = "${local.domain_name}-msk-ec2client-policy"
  description = "This policy used in ${local.domain_name} with permissions needed."
  policy      = data.aws_iam_policy_document.extrato_lancamento_policy_document.json
}

resource "aws_iam_role_policy_attachment" "extrato_lancamento_ssm_full_access_role_policy_attachment" {
  role       = aws_iam_role.extrato_lancamento_msk_ec2client_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
}

resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.extrato_lancamento_msk_ec2client_role.name
  policy_arn = aws_iam_policy.extrato_lancamento_msk_ec2client_policy.arn
}
