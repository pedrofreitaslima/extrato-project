#######################################################################################################################
#### General variables
#######################################################################################################################
variable "domain_name" {
  type        = string
  default     = ""
  description = "Please enter the domain name that is prefixed to resource names"
}

variable "environment" {
  type        = string
  default     = ""
  description = "Please enter the enviroment name for this resources created"

  validation {
    condition     = contains(["development", "stagging", "release"], var.environment)
    error_message = "Valid values for var: environment are ('developement', 'stagging', 'release')."
  }
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
#### Security variables
#######################################################################################################################


#######################################################################################################################
#### Observability variables
#######################################################################################################################



#######################################################################################################################
#### MSK variables
#######################################################################################################################


#######################################################################################################################
#### Glue variables
#######################################################################################################################
