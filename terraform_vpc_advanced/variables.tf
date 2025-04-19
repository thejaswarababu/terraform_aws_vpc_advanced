variable "cidr_block" {
    type = string
  
}

variable "enable_dns_hostnames" {
    default = "true"
  
}

variable "enable_dns_support" {
    default = "true"
  
}


variable "project_name" {
    type = string
  
}

variable "common_tags" {
    type = map
  
}

variable "env" {
    type = string
  
}

variable "vpc_tags" {
    type = map
  
}

variable "igw_tags" {
    type = map
  
}

#public subnet variables

variable "public_subnet_cidr_block" {
    type=list
    validation {
      condition = length(var.public_subnet_cidr_block) == 2
      error_message = "please enter minimum 2 cidr blocks "
    }
  
}

variable "public_subnet_tags" {
    type = map
  
}


# private subnet variables


variable "private_subnet_cidr_block" {
    type = list
     validation {
      condition = length(var.private_subnet_cidr_block) == 2
      error_message = "please enter minimum 2 cidr blocks "
    }
  
}

variable "private_subnet_tags" {
 type = map 
}

# database subnet variables


variable "database_subnet_cidr_block" {
    type = list
     validation {
      condition = length(var.database_subnet_cidr_block) == 2
      error_message = "please enter minimum 2 cidr blocks "
    }
  
}
variable "database_subnet_tags" {
    type = map
  
}

# public route table tags

variable "public_rt_tags" {
    default = map
  
}

# nat gateway tags

variable "nat_gateway_tags" {
    type = map
  
}

variable "private_rt_tags" {
    type = map
  
}

variable "databse_rt_tags" {

    type = map
  
}

variable "database_Subnet_group_tags" {
    type = map
  
}