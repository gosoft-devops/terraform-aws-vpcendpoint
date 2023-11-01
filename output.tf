output "vpc_endpoint_id" {
  value = { for k, vpce in aws_vpc_endpoint.default : k => vpce.id }
}
output "vpc_endpoint_dns" {
  value = values({ for k, vpce in aws_vpc_endpoint.default : k => vpce.dns_entry })
}
output "vpce_security_group_name" {
  value = { for k, sc in aws_security_group.default : k => sc.id }
}
