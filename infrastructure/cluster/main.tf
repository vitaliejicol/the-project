module "vpc" {
  source = "terraform-redhat/rosa-hcp/rhcs//modules/vpc"

  name_prefix              = "paymentology-vpc"
  availability_zones_count = 3
}

module "hcp" {
  source = "terraform-redhat/rosa-hcp/rhcs"

  cluster_name           = "paymentology-cluster"
  openshift_version      = "4.20.8"
  machine_cidr           = "10.0.0.0/16"
  aws_subnet_ids         = ["${module.vpc.public_subnets[0]}", "${module.vpc.public_subnets[1]}", "${module.vpc.public_subnets[2]}", "${module.vpc.private_subnets[0]}", "${module.vpc.private_subnets[1]}", "${module.vpc.private_subnets[2]}"]
  aws_availability_zones = module.vpc.availability_zones
  replicas               = 3

  // STS configuration
  create_account_roles  = true
  account_role_prefix   = "paymentology-cluster-account"
  create_oidc           = true
  create_operator_roles = true
  operator_role_prefix  = "paymentology-cluster-operator"

  create_admin_user = true
  admin_credentials_username = "vitaliejicol"
  admin_credentials_password = "StrongPassword123!"
}