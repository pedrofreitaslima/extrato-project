locals {
  domain_name     = "extrato-lancamento-efetivado"
  project_purpose = "dry-run-aws"
  author_name     = "pedrofreitaslima"
  custom_tags = {
    "ProjectName"    = local.domain_name,
    "Environment"    = var.environment,
    "ProjectPurpose" = local.project_purpose,
    "Author"         = local.author_name
  }
}