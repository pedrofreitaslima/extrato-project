#######################################################################################################################
#### General
#######################################################################################################################
variable "domain_name" {
  type        = string
  default     = ""
  description = "Please enter the domain name that is prefixed to resource names"
}

variable "project_purpose" {
  type        = string
  default     = ""
  description = "Please enter the purpose of this project"
}

variable "author_name" {
  type        = string
  default     = ""
  description = "Please enter the author name to created this project"
}

variable "custom_tags" {
  type        = map(string)
  default     = {}
  description = "A map of custom tags to be applied to all resources"
}

#######################################################################################################################
#### Networking variables
#######################################################################################################################
variable "vpc_cidr" {
  type        = string
  default     = ""
  description = "Please enter the IP range (CIDR notation) for this VPC"
}

variable "public_subnet1_cidr" {
  type        = string
  default     = ""
  description = "Please enter the IP range (CIDR notation) for the public subnet in the first Availability Zone"
}

variable "public_subnet2_cidr" {
  type        = string
  default     = ""
  description = "Please enter the IP range (CIDR notation) for the public subnet in the second Availability Zone"
}

variable "public_subnet3_cidr" {
  type        = string
  default     = ""
  description = "Please enter the IP range (CIDR notation) for the public subnet in the third Availability Zone"
}

variable "private_subnet1_cidr" {
  type        = string
  default     = ""
  description = "Please enter the IP range (CIDR notation) for the private subnet in the first Availability Zone"
}

variable "private_subnet2_cidr" {
  type        = string
  default     = ""
  description = "Please enter the IP range (CIDR notation) for the private subnet in the second Availability Zone"
}

variable "private_subnet3_cidr" {
  type        = string
  default     = ""
  description = "Please enter the IP range (CIDR notation) for the private subnet in the third Availability Zone"
}

#######################################################################################################################
#### MSK variables
#######################################################################################################################
variable "schema_name" {
  type        = string
  default     = ""
  description = "Please enter the schema name"
}

#######################################################################################################################
#### Glue variables
#######################################################################################################################
variable "glue_job_script_location" {
  type        = string
  default     = ""
  description = "Please enter the s3 location of the glue job script"
}

variable "max_concurrent_runs" {
  type        = number
  default     = 1
  description = "The maximum number of concurrent runs allowed for a job"
}

variable "worker_type" {
  type        = string
  default     = "G.1X"
  description = "Please enter the worker type for AWS Glue (e.g. Standard, G.2X, G.1X)"
}

variable "number_of_workers" {
  type        = number
  default     = 3
  description = "The number of workers of a given WorkerType that are allocated when the job runs"
}

variable "glue_version" {
  type        = string
  default     = "3.0"
  description = "Please enter the Glue version (e.g. 3.0, 2.0)"
}

#######################################################################################################################
#### Observability
#######################################################################################################################
variable "retention_period" {
  type        = number
  default     = 1
  description = "Please enter the retention period in days"
}

#######################################################################################################################
#### OpenSearch variables
#######################################################################################################################
