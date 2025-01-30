resource "aws_glue_connection" "extrato_lancamento_glue_connection" {
  name            = "${local.domain_name}-glue-connection"
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

resource "aws_glue_catalog_database" "extrato_lancamento_glue_catalog_database" {
  name       = "${local.domain_name}-catalog-database"
  catalog_id = data.aws_caller_identity.current.account_id
}

resource "aws_glue_catalog_table" "extrato_lancamento_glue_catalog_table" {
  name          = "${local.domain_name}-catalog-table"
  database_name = aws_glue_catalog_database.extrato_lancamento_glue_catalog_database.name
  catalog_id    = data.aws_caller_identity.current.account_id

  table_type = "EXTERNAL_TABLE"

  parameters = {
    classification = "csv"
    connectionName = aws_glue_connection.extrato_lancamento_glue_connection.name
  }

  storage_descriptor {
    location      = "${local.domain_name}-topic"
    input_format  = "org.apache.hadoop.mapred.TextInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"

    ser_de_info {
      serialization_library = "org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe"
      parameters = {
        "separatorChar" = ","
      }
    }

    columns {
      name = "year"
      type = "bigint"
    }

    columns {
      name = "month"
      type = "bigint"
    }

    columns {
      name = "day"
      type = "bigint"
    }

    columns {
      name = "dep_time"
      type = "bigint"
    }

    columns {
      name = "dep_delay"
      type = "bigint"
    }

    columns {
      name = "arr_time"
      type = "bigint"
    }

    columns {
      name = "arr_delay"
      type = "bigint"
    }

    columns {
      name = "carrier"
      type = "string"
    }

    columns {
      name = "tailnum"
      type = "string"
    }

    columns {
      name = "flight"
      type = "bigint"
    }

    columns {
      name = "origin"
      type = "string"
    }

    columns {
      name = "dest"
      type = "string"
    }

    columns {
      name = "air_time"
      type = "bigint"
    }

    columns {
      name = "distance"
      type = "bigint"
    }

    columns {
      name = "hour"
      type = "bigint"
    }

    columns {
      name = "minute"
      type = "bigint"
    }
  }
}

resource "aws_glue_job" "extrato_lancamento_glue_job" {
  name        = "${local.domain_name}-glue-job"
  description = "Glue Job to process data from Kafka topic"
  role_arn    = aws_iam_role.extrato_lancamento_glue_role.arn
  connections = [
    aws_glue_connection.extrato_lancamento_glue_connection.name
  ]

  command {
    name            = "gluestreaming"
    python_version  = "3"                                                                                            # TODO: create a variable for this
    script_location = "s3://${aws_s3_bucket.extrato_lancamento_gluescript_bucket.bucket}/mskserverlessprocessing.py" # TODO: change for scala
  }

  execution_property {
    max_concurrent_runs = 1 # TODO: create a variable for this
  }
  worker_type       = "G.1X" # TODO: create a variable for this
  number_of_workers = 3      # TODO: create a variable for this
  glue_version      = "4.0"  # TODO: create a variable for this
  default_arguments = {
    #"--continuous-log-logGroup"          = aws_cloudwatch_log_group.example.name # TODO enable dedicated cloud watch group
    "--enable-continuous-cloudwatch-log" : "true"
    "--enable-job-insights" : "true"
    "--enable-metrics" : "true"
    "--enable-spark-ui" : "true"
    "--job-bookmark-option" : "job-bookmark-disable"
    "--spark-event-logs-path" : "s3://${aws_s3_bucket.extrato_lancamento_gluescript_bucket.bucket}/eventlogs/"
    "--database_name" : aws_glue_catalog_database.extrato_lancamento_glue_catalog_database.name
    "--table_name" : aws_glue_catalog_table.extrato_lancamento_glue_catalog_table.name
    "--topic_name" : "${local.domain_name}-topic"
    "--dest_dir" : "s3://${aws_s3_bucket.extrato_lancamento_glueoutput_bucket.bucket}/"
  }

  tags = local.custom_tags
}