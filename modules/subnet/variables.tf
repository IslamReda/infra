variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "cidr_block" {
  description = "CIDR block for the subnet"
  type        = string
}

variable "name" {
  description = "Name for the subnet resources"
  type        = string
}

variable "public" {
  description = "Whether the subnet is public"
  type        = bool
}

variable "gateway_id" {
  description = "Gateway ID for public subnets"
  type        = string
  default     = ""
}
