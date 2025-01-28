resource "aws_iam_role" "extrato_lancamento_msk_ec2client_role" {
  name               = "${local.domain_name}-msk-ec2client-role"
  assume_role_policy = data.aws_iam_policy_document.extrato_lancamento_assume_role_policy_msk_ec2client.json
  tags               = local.custom_tags
}

resource "aws_iam_role_policy_attachment" "extrato_lancamento_ssm_full_access_role_policy_attachment" {
  role       = aws_iam_role.extrato_lancamento_msk_ec2client_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
}

data "aws_iam_policy_document" "extrato_lancamento_assume_role_policy_msk_ec2client" {
  statement {
    sid     = "AllowAssumeRoleEC2"
    actions = [
      "sts:AssumeRole"
    ]
    effect = "Allow"
    resources = [
      "*"
    ]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }

  statement {
    sid     = "AllowReadWriteAccessMSKCluster"
    actions = [
      "kafka-cluster:Connect",
      "kafka-cluster:AlterCluster",
      "kafka-cluster:DescribeCluster"
    ]
    effect = "Allow"
    resources = [
      "*" # TODO: Alter to cluster MSK serverless ARN
    ]
    principals {
      type        = "Service"
      identifiers = ["kafkaclient.amazonaws.com"]
    }
  }

  statement {
    sid     = "AllowReadWriteAccessMSKClusterTopic"
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
    principals {
      type        = "Service"
      identifiers = ["kafkaclient.amazonaws.com"]
    }
  }

  statement {
    sid     = "AllowReadWriteAccessMSKClusterGroup"
    actions = [
      "kafka-cluster:AlterGroup",
      "kafka-cluster:DescribeGroup"
    ]
    effect = "Allow"
    resources = [
      "arn:aws:kafka:${data.aws_region.current.id}:${data.aws_caller_identity.current.account_id}:group/${local.domain_name}/*/*"
    ]
    principals {
      type        = "Service"
      identifiers = ["kafkaclient.amazonaws.com"]
    }
  }

  statement {
    sid     = "AllowMSKS3"
    actions = [
      "s3:Get*",
      "s3:PutObject*",
      "s3:List*"
    ]
    effect = "Allow"
    resources = [
      "*" # TODO: Alter to add S3 bucket ARN
    ]
    principals {
      type        = "Service"
      identifiers = ["s3.amazonaws.com"]
    }
  }
}