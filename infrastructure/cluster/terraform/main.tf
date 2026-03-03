

######## Create ROSA HCP Cluster ###########

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
  admin_credentials_username = var.admin_credentials_username
  admin_credentials_password = var.admin_credentials_password
}

######### Create ECR ###########

# Fetch AWS account ID
data "aws_caller_identity" "current" {}

# Define the list of repositories you want to create
locals {
  repositories = ["api", "worker", "frontend"]
}

# Loop over each repo to create an ECR repository
module "ecr" {
  source = "terraform-aws-modules/ecr/aws"

  for_each = toset(local.repositories)

  repository_name = each.value

  repository_read_write_access_arns = [
    "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/terraform_cloud"
  ]

  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Keep last 30 images"
        selection = {
          tagStatus     = "tagged"
          tagPrefixList = ["v"]
          countType     = "imageCountMoreThan"
          countNumber   = 30
        }
        action = {
          type = "expire"
        }
      }
    ]
  })

  tags = {
    Terraform   = "true"
    Environment = "prod"
  }
}

# ######### Create KMS ###########
# # Define the keys you want to create
# locals {
#   kms_keys = [
#     {
#       name  = "qa_decrypt"
#       alias = "alias/qa_decrypt_key"
#     },
#     {
#       name  = "uat_decrypt"
#       alias = "alias/uat_decrypt_key"
#     },
#     {
#       name  = "prod_decrypt"
#       alias = "alias/prod_decrypt_key"
#     }
#   ]
# }

# # Loop over each key
# module "kms_key" {
#   source = "cloudposse/kms-key/aws"
#   # version = "x.x.x"  # pin to a specific module version

#   for_each = { for key in local.kms_keys : key.name => key }

#   namespace               = "eg"
#   stage                   = "test"
#   name                    = each.value.name
#   description             = "KMS key for ${each.value.name}"
#   deletion_window_in_days = 10
#   enable_key_rotation     = true
#   alias                   = each.value.alias
# }