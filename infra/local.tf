locals {
  domain_name     = "extrato-lancamento-efetivado"
  project_purpose = "aws-dry-run-for-itau-extrato"
  author_name     = "pedrofreitaslima"
  custom_tags = {
    "ProjectName"    = local.domain_name,
    "ProjectPurpose" = local.project_purpose,
    "Author"         = local.author_name
  }
  schema_name = "ExtratoLancamentoEfetivado"
}