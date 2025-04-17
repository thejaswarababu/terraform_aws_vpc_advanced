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
  
}

variable "public_subnet_tags" {
    type = map
  
}


# private subnet variables


variable "private_subnet_cidr_block" {
    type = list
  
}

variable "private_subnet_tags" {
 type = map 
}

# database subnet variables


variable "database_subnet_cidr_block" {
    type = list
  
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
