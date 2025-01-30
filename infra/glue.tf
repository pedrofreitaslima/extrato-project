#######################################################################################################################
#### Glue Registries
#######################################################################################################################
resource "aws_glue_registry" "extrato_lancamento_glue_registry" {
  registry_name = "${local.domain_name}-registry"
  description   = "Glue Registry for ${local.domain_name} domain which contains 2 schemas"
  tags          = local.custom_tags
}

#######################################################################################################################
#### Glue Schemas
#######################################################################################################################
resource "aws_glue_schema" "extrato_lancamento_glue_schema_avro" {
  schema_name   = "${local.domain_name}-schema-avro"
  description   = "Glue Schema for ${local.domain_name} in format AVRO to MSK Kafka."
  registry_arn  = aws_glue_registry.extrato_lancamento_glue_registry.arn
  data_format   = "AVRO"
  compatibility = "BACKWARD"
  schema_definition = jsonencode({
    type      = "record"
    name      = local.schema_name
    namespace = "br.com.itau.${local.domain_name}"
    fields = [
      {
        name = "numero_identificacao_lancamento_conta"
        type = "string"
      },
      {
        name = "valor_lancamento"
        type = "double"
      },
      {
        name = "codigo_moeda_transacao"
        type = "string"
      },
      {
        name = "tipo_evento"
        type = "string"
      },
      {
        name = "sigla_sistema_origem"
        type = "string"
      },
      {
        name = "codigo_motivo_lancamento"
        type = "string"
      },
      {
        name = "descricao_curta"
        type = "string"
      },
      {
        name = "descricao_completa"
        type = "string"
      },
      {
        name = "indicador_lancamento_visivel_cliente"
        type = "boolean"
      },
      {
        name = "indicador_lancamento_compulsorio_ocorrencia"
        type = "boolean"
      },
      {
        name = "indicador_lancamento_compulsorio_saldo"
        type = "boolean"
      },
      {
        name = "indicador_estorno"
        type = "boolean"
      },
      {
        name = "conta"
        type = {
          type = "record"
          name = "Conta"
          fields = [
            {
              name = "numero_unico_conta"
              type = "string"
            },
            {
              name = "codigo_tipo_sub_conta"
              type = "string"
            }
          ]
        }
      }
    ]
  })
  tags = local.custom_tags
}

resource "aws_glue_schema" "extrato_lancamento_glue_schema_json" {
  schema_name   = "${local.domain_name}-schema-json"
  description   = "Glue Schema for ${local.domain_name} in format JSON to OpenSearch."
  registry_arn  = aws_glue_registry.extrato_lancamento_glue_registry.arn
  data_format   = "JSON"
  compatibility = "BACKWARD"
  schema_definition = jsonencode({
    "$schema" : "http://json-schema.org/draft-07/schema#",
    "type" : "object",
    "properties" : {
      "numeroIdentificacaoLancamentoConta" : {
        "type" : "string"
      },
      "valorLancamento" : {
        "type" : "number"
      },
      "codigoMoedaTransacao" : {
        "type" : "string"
      },
      "tipoEvento" : {
        "type" : "string"
      },
      "siglaSistemaOrigem" : {
        "type" : "string"
      },
      "codigoMotivoLancamento" : {
        "type" : "string"
      },
      "descricaoCurta" : {
        "type" : "string"
      },
      "descricaoCompleta" : {
        "type" : "string"
      },
      "indicadorLancamentoVisivelCliente" : {
        "type" : "boolean"
      },
      "indicadorLancamentoCompulsorioOcorrencia" : {
        "type" : "boolean"
      },
      "indicadorLancamentoCompulsorioSaldo" : {
        "type" : "boolean"
      },
      "indicadorEstorno" : {
        "type" : "boolean"
      },
      "conta" : {
        "type" : "object",
        "properties" : {
          "numeroUnicoConta" : {
            "type" : "string"
          },
          "codigoTipoSubConta" : {
            "type" : "string"
          }
        }
      },
      "indicadorDetalhes" : {
        "type" : "boolean"
      },
      "dataContabil" : {
        "type" : "string",
        "format" : "date"
      },
      "dataHoraLancamento" : {
        "type" : "string",
        "format" : "date-time"
      },
      "dataHoraVisualizacao" : {
        "type" : "string",
        "format" : "date-time"
      },
      "indicadorDebito" : {
        "type" : "boolean"
      },
      "codigoLegenda" : {
        "type" : "string"
      },
      "descricaoLegenda" : {
        "type" : "string"
      },
      "dica" : {
        "type" : "string"
      },
      "codigoAgrupamento" : {
        "type" : "string"
      },
      "indicadorAnotacao" : {
        "type" : "boolean"
      },
      "indicadorLancamentoFinalOito" : {
        "type" : "boolean"
      },
      "contraParteTransacao" : {
        "type" : "object",
        "properties" : {
          "codigoTipoConta" : {
            "type" : "string"
          },
          "codigoIspb" : {
            "type" : "string"
          },
          "numeroAgenciaConta" : {
            "type" : "string"
          },
          "numeroConta" : {
            "type" : "string"
          },
          "numeroDigitoVerificadorConta" : {
            "type" : "string"
          },
          "nomeClienteConta" : {
            "type" : "string"
          },
          "numeroDocumentoConta" : {
            "type" : "string"
          },
          "codigoTipoPessoaConta" : {
            "type" : "string"
          }
        }
      },
      "origemTransacao" : {
        "type" : "object",
        "properties" : {
          "textoTipoOperacaoSistemaOrigem" : {
            "type" : "string"
          },
          "siglaSistemaOrigem" : {
            "type" : "string"
          },
          "identificadorOrigemTransacao" : {
            "type" : "string"
          },
          "identificadorProduto" : {
            "type" : "string"
          },
          "complementoCanal" : {
            "type" : "string"
          }
        }
      }
    }
  })
  tags = local.custom_tags
}

#######################################################################################################################
#### Glue Catalog Database
#######################################################################################################################
resource "aws_glue_catalog_database" "extrato_lancamento_glue_catalog_database" {
  name       = "${local.domain_name}-catalog-database"
  catalog_id = data.aws_caller_identity.current.account_id
}

#######################################################################################################################
#### Glue Catalog Table
#######################################################################################################################
resource "aws_glue_catalog_table" "extrato_lancamento_glue_catalog_table" {
  name          = "${local.domain_name}-catalog-table"
  database_name = aws_glue_catalog_database.extrato_lancamento_glue_catalog_database.name

  table_type = "EXTERNAL_TABLE"

  parameters = {
    "classification"                       = "avro"
    "typeOfData"                           = "file"
    "averageRecordSize"                    = "100"
    "compressionType"                      = "none"
    "enable-updating-partition-statistics" = "true"
    "schema.version"                       = "1.0"
  }

  storage_descriptor {
    location      = "s3://${aws_s3_bucket.extrato_lancamento_input_glue_bucket.bucket}${var.glue_job_script_location}"
    input_format  = "org.apache.hadoop.hive.ql.io.avro.AvroContainerInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.avro.AvroContainerOutputFormat"

    ser_de_info {
      name                  = "${local.domain_name}_avro_serde"
      serialization_library = "org.apache.hadoop.hive.serde2.avro.AvroSerDe"

      parameters = {
        "serialization.format" = "1"
        "avro.schema.literal" = jsonencode({
          type      = "record"
          name      = var.schema_name
          namespace = "br.com.itau.${local.domain_name}"
          fields = [
            {
              name = "numero_identificacao_lancamento_conta"
              type = "string"
            },
            {
              name = "valor_lancamento"
              type = "double"
            },
            {
              name = "codigo_moeda_transacao"
              type = "string"
            },
            {
              name = "tipo_evento"
              type = "string"
            },
            {
              name = "sigla_sistema_origem"
              type = "string"
            },
            {
              name = "codigo_motivo_lancamento"
              type = "string"
            },
            {
              name = "descricao_curta"
              type = "string"
            },
            {
              name = "descricao_completa"
              type = "string"
            },
            {
              name = "indicador_lancamento_visivel_cliente"
              type = "boolean"
            },
            {
              name = "indicador_lancamento_compulsorio_ocorrencia"
              type = "boolean"
            },
            {
              name = "indicador_lancamento_compulsorio_saldo"
              type = "boolean"
            },
            {
              name = "indicador_estorno"
              type = "boolean"
            },
            {
              name = "conta"
              type = {
                type = "record"
                name = "Conta"
                fields = [
                  {
                    name = "numero_unico_conta"
                    type = "string"
                  },
                  {
                    name = "codigo_tipo_sub_conta"
                    type = "string"
                  }
                ]
              }
            }
          ]
        })
      }
    }

    columns {
      name = "numero_identificacao_lancamento_conta"
      type = "string"
    }
    columns {
      name = "valor_lancamento"
      type = "double"
    }
    columns {
      name = "codigo_moeda_transacao"
      type = "string"
    }
    columns {
      name = "tipo_evento"
      type = "string"
    }
    columns {
      name = "sigla_sistema_origem"
      type = "string"
    }
    columns {
      name = "codigo_motivo_lancamento"
      type = "string"
    }
    columns {
      name = "descricao_curta"
      type = "string"
    }
    columns {
      name = "descricao_completa"
      type = "string"
    }
    columns {
      name = "indicador_lancamento_visivel_cliente"
      type = "boolean"
    }
    columns {
      name = "indicador_lancamento_compulsorio_ocorrencia"
      type = "boolean"
    }
    columns {
      name = "indicador_lancamento_compulsorio_saldo"
      type = "boolean"
    }
    columns {
      name = "indicador_estorno"
      type = "boolean"
    }
    columns {
      name = "conta"
      type = "struct<numero_unico_conta:string,codigo_tipo_sub_conta:string>"
    }
  }
}

#######################################################################################################################
#### Glue Connection
#######################################################################################################################
resource "aws_glue_connection" "extrato_lancamento_glue_connection" {
  name            = "${local.domain_name}-connection"
  catalog_id      = data.aws_caller_identity.current.account_id
  connection_type = "KAFKA"

  connection_properties = {
    KAFKA_BOOTSTRAP_SERVERS = aws_msk_serverless_cluster.extrato_lancamento_msk_serverless_cluster.cluster_name
    KAFKA_SSL_ENABLED       = true
    KAFKA_SASL_MECHANISM    = "AWS_MSK_IAM"
  }

  physical_connection_requirements {
    availability_zone      = aws_subnet.extrato_lancamento_private_subnet_1.availability_zone
    security_group_id_list = [aws_security_group.extrato_lancamento_sg.id]
    subnet_id              = aws_subnet.extrato_lancamento_private_subnet_1.id
  }

  tags = local.custom_tags
}

#######################################################################################################################
#### Glue Job
#######################################################################################################################
resource "aws_glue_job" "extrato_lancamento_glue_job" {
  name        = "${local.domain_name}-job"
  description = "Glue Job to process data from Kafka topic"
  role_arn    = aws_iam_role.extrato_lancamento_glue_role.arn
  connections = [
    aws_glue_connection.extrato_lancamento_glue_connection.name
  ]

  command {
    # TODO: change for scala
    name            = "gluestreaming"
    python_version  = "3"
    script_location = "s3://${aws_s3_bucket.extrato_lancamento_input_glue_bucket.bucket}/mskserverlessprocessing.py"
  }

  execution_property {
    max_concurrent_runs = var.max_concurrent_runs
  }
  worker_type       = var.worker_type
  number_of_workers = var.number_of_workers
  glue_version      = var.glue_version
  default_arguments = {
    "--continuous-log-logGroup" : aws_cloudwatch_log_group.extrato_lancamento_glue_job_log_group.name
    "--enable-continuous-cloudwatch-log" : "true"
    "--enable-job-insights" : "true"
    "--enable-metrics" : "true"
    "--enable-spark-ui" : "true"
    "--job-bookmark-option" : "job-bookmark-disable"
    "--spark-event-logs-path" : "s3://${aws_s3_bucket.extrato_lancamento_output_glue_bucket.bucket}/eventlogs/"
    "--database_name" : aws_glue_catalog_database.extrato_lancamento_glue_catalog_database.name
    "--table_name" : aws_glue_catalog_table.extrato_lancamento_glue_catalog_table.name
    "--topic_name" : "${local.domain_name}-topic"
    "--dest_dir" : "s3://${aws_s3_bucket.extrato_lancamento_output_glue_bucket.bucket}/output/"
  }

  tags = local.custom_tags
}