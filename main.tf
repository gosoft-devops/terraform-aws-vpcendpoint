data "aws_route_tables" "default" {
  vpc_id = var.vpc_id
}

data "aws_vpc_endpoint_service" "default" {
  for_each = var.vpc_endpoint

  service      = lookup(each.value, "service", null)
  service_name = lookup(each.value, "service_name", null)
  service_type = lookup(each.value, "service_type", "Interface")
}
data "aws_vpc" "selected" {
  id = var.vpc_id
}

data "aws_subnets" "app" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
  tags = {
    Name = "*app*"
  }
}

resource "aws_vpc_endpoint" "default" {
  for_each = var.vpc_endpoint

  vpc_id            = var.vpc_id
  vpc_endpoint_type = lookup(each.value, "service_type", "Interface")
  service_name      = data.aws_vpc_endpoint_service.default[each.key].service_name

  subnet_ids          = lookup(each.value, "service_type", "Interface") == "Interface" ? data.aws_subnets.app.ids : []
  route_table_ids     = lookup(each.value, "service_type", "Interface") == "Gateway" ? data.aws_route_tables.default.ids : null
  security_group_ids  = lookup(each.value, "service_type", "Interface") == "Interface" ? distinct(concat(aws_security_group.default.*.id, lookup(each.value, "security_group_ids", var.security_group_ids))) : null
  private_dns_enabled = lookup(each.value, "service_type", "Interface") == "Interface" ? lookup(each.value, "private_dns_enabled", false) : false

  tags = merge(var.tags, {
    Name = lookup(each.value, "tags_name", "${var.tags["Service"]}-${var.tags["System"]}-${each.key}-vpce")
  })
}

resource "random_string" "default" {
  length  = 5
  special = false
  upper   = false
}

resource "aws_security_group" "default" {
  count = var.enable_security_group ? 1 :0

  vpc_id      = var.vpc_id
  name        = "${var.tags["Service"]}-${var.tags["System"]}-vpce-${random_string.default.result}-sg"
  description = "Allow Oasis vpce for ${var.tags["Service"]}-${var.tags["System"]}"

  ingress {
    description = "vpce"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.selected.cidr_block_associations[0].cidr_block]
    # ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description = "vpce"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.selected.cidr_block_associations[0].cidr_block]
    # ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description = "vpce"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.selected.cidr_block_associations[1].cidr_block]
    # ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description = "vpce"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.selected.cidr_block_associations[1].cidr_block]
    # ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    description      = "egress to any"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(var.tags, {
    Name = "${var.tags["Service"]}-${var.tags["System"]}-vpce-${random_string.default.result}-sg"
  })
}
