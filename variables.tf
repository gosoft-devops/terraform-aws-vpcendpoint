variable "tags" {
  type        = any
  description = "Tagging resource"
}
# variable "tag_service" {
#   type        = string
#   description = "The service code id, example sds, rpa or etc."
# }
# variable "tag_system" {
#   type        = string
#   description = "The system code id, example: sss, sms or etc."
# }
# variable "environment" {
#   type        = string
#   description = "The environmmet for deploy, example: dev, production or etc."
# }
variable "vpc_id" {
  description = "VPC ID in which will be used."
  type        = string
}
variable "vpc_endpoint" {
  description = "map interface or gateway in which use configurations."
  type        = any
  default     = {}
}
variable "security_group_ids" {
  description = "Default security group IDs to associate with the VPC endpoints"
  type        = list(string)
  default     = []
}
variable "enable_security_group" {
  type    = bool
  default = true
}