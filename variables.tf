variable "domain_name" {
  type        = string
  default     = ""
  description = "The domain name of this project"
}

variable "project_purpose" {
  type        = string
  default     = ""
  description = "The purpose of this project"
}

variable "custom_tags" {
  type        = map(string)
  default     = {}
  description = "A map of custom tags to be applied to all resources"
}