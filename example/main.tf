locals {
  tags_01 = {
    Service     = ""
    System      = ""
    Owner       = ""
    Project     = ""
    Environment = ""
    Manageby    = "terraform"
    Createby    = ""
  }

  tags_02 = {
    Service     = ""
    System      = ""
    Owner       = ""
    Project     = ""
    Environment = ""
    Manageby    = "terraform"
    Createby    = ""
  }
}

module "vpc_endpoint_vpc_000" {
  source = "github.com/gosoft-devops/terraform-aws-vpcendpoint?ref=v1.0.0"

  vpc_id = ""
  # enable_security_group = false  ## False when custom Security Group.
  # security_group_ids = [""]
  vpc_endpoint = {
    s3 = {
      service      = "s3"
      service_type = "Gateway"
    }
    dynamodb = {
      service      = "dynamodb"
      service_type = "Gateway"
    }
    api_gateway = {
      service             = "execute-api"
      service_type        = "Interface"
      private_dns_enabled = false
    }
    ecrapi = {
      service             = "ecr.api"
      service_type        = "Interface"
      private_dns_enabled = true
    }
    ecrdkr = {
      service             = "ecr.dkr"
      service_type        = "Interface"
      private_dns_enabled = true
    }
    cloudwatchlogs = {
      service             = "logs"
      service_type        = "Interface"
      private_dns_enabled = false
    }
    sqs = {
      service             = "sqs"
      service_type        = "Interface"
      private_dns_enabled = false
    }
    sns = {
      service             = "sns"
      service_type        = "Interface"
      private_dns_enabled = false
    }
  }

  tags = local.tags_01
}
module "vpc_endpoint_vpc_111" {
  source = "github.com/gosoft-devops/terraform-aws-vpcendpoint?ref=v1.0.0"

  vpc_id = ""
  # enable_security_group = false  ## False when custom Security Group.
  # security_group_ids = [""]
  vpc_endpoint = {
    s3 = {
      service      = "s3"
      service_type = "Gateway"
    }
    dynamodb = {
      service      = "dynamodb"
      service_type = "Gateway"
    }
    api_gateway = {
      service             = "execute-api"
      service_type        = "Interface"
      private_dns_enabled = false
    }
    ecrapi = {
      service             = "ecr.api"
      service_type        = "Interface"
      private_dns_enabled = true
    }
    ecrdkr = {
      service             = "ecr.dkr"
      service_type        = "Interface"
      private_dns_enabled = true
    }
    cloudwatchlogs = {
      service             = "logs"
      service_type        = "Interface"
      private_dns_enabled = false
    }
    sqs = {
      service             = "sqs"
      service_type        = "Interface"
      private_dns_enabled = false
    }
    sns = {
      service             = "sns"
      service_type        = "Interface"
      private_dns_enabled = false
    }
  }

  tags = local.tags_02
}
