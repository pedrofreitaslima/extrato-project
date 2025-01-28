#######################################################################################################################
#### General
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

variable "instance_type_ec2" {
  type        = string
  default     = ""
  description = "Please enter the instance type for EC2"
  validation {
    condition     = contains(["t2.micro", "t2.small", "t2.medium", "t3.micro", "t3.small", "t3.medium", "t3.large"], var.instance_type_ec2)
    error_message = "Valid values for var: instance_type_ec2 are ('t2.micro', 't2.small', 't2.medium', 't3.micro', 't3.small', 't3.medium', 't3.large')."
  }
}

variable "latest_ami_id" {
  type        = string
  default     = "ami-0f214d1b3d031dc53"
  description = "Please enter latest AMI ID of Amazon Linux 2 for ec2 instance. You can use the default value."
}

#######################################################################################################################
#### Networking
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
