#######################################################################################################################
#### S3 Buckets
#######################################################################################################################
resource "aws_s3_bucket" "extrato_lancamento_glueoutput_bucket" {
  bucket = "aws-glueoutput-${data.aws_caller_identity.current.account_id}-${data.aws_region.current.id}-${local.domain_name}"
  tags   = local.custom_tags
}

resource "aws_s3_bucket" "extrato_lancamento_gluescript_bucket" {
  bucket = "aws-gluescript-${data.aws_caller_identity.current.account_id}-${data.aws_region.current.id}-${local.domain_name}"
  tags   = local.custom_tags
}

#######################################################################################################################
#### Public Access Block
#######################################################################################################################
resource "aws_s3_bucket_public_access_block" "extrato_lancamento_glueoutput_public_access_block" {
  bucket                  = aws_s3_bucket.extrato_lancamento_glueoutput_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "extrato_lancamento_gluescript_public_access_block" {
  bucket                  = aws_s3_bucket.extrato_lancamento_gluescript_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}