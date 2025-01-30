#######################################################################################################################
#### S3 Buckets
#######################################################################################################################
resource "aws_s3_bucket" "extrato_lancamento_input_glue_bucket" {
  bucket = "${local.domain_name}-input-glue"
  tags   = local.custom_tags
}

resource "aws_s3_bucket" "extrato_lancamento_output_glue_bucket" {
  bucket = "${local.domain_name}-output-glue"
  tags   = local.custom_tags
}

#######################################################################################################################
#### Public Access Block
#######################################################################################################################
resource "aws_s3_bucket_public_access_block" "extrato_lancamento_input_glue_public_access_block" {
  bucket                  = aws_s3_bucket.extrato_lancamento_input_glue_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "extrato_lancamento_output_glue_public_access_block" {
  bucket                  = aws_s3_bucket.extrato_lancamento_output_glue_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}