output "vpce-id" {
  value = module.vpc_endpoint.vpc_endpoint_id
}

output "vpce-dns" {
  value = module.vpc_endpoint.vpc_endpoint_dns[0][0]["dns_name"]
}
