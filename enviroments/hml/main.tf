provider "aws" {
  region = "us-east-1"
}

module "network" {
  source = "../modules/network"
}

module "waf" {
  source = "../modules/waf"
}

module "api_gateway" {
  source = "../modules/api_gateway"
}
