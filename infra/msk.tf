resource "aws_msk_serverless_cluster" "extrato_lancamento_msk_serverless_cluster" {
  cluster_name = "${local.domain_name}-cluster"

  vpc_config {
    subnet_ids = [
      aws_subnet.extrato_lancamento_public_subnet_1.id,
      aws_subnet.extrato_lancamento_public_subnet_2.id,
      aws_subnet.extrato_lancamento_public_subnet_3.id
    ]
    security_group_ids = [
      aws_security_group.extrato_lancamento_sg.id
    ]
  }

  client_authentication {
    sasl {
      iam {
        enabled = true
      }
    }
  }

  tags = local.custom_tags
}

resource "aws_mskconnect_custom_plugin" "extrato_lancamento_mskconnect_custom_plugin" {
  name         = "debezium-example"
  content_type = "ZIP"
  location {
    s3 {
      ser = aws_s3_bucket.example.arn
      file_key   = aws_s3_object.example.key
    }
  }
}