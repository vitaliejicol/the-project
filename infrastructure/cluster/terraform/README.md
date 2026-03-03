## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.38.0 |
| <a name="requirement_rhcs"></a> [rhcs](#requirement\_rhcs) | >= 1.7.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.38.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ecr"></a> [ecr](#module\_ecr) | terraform-aws-modules/ecr/aws | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_credentials_password"></a> [admin\_credentials\_password](#input\_admin\_credentials\_password) | Admin password for the OpenShift cluster | `string` | n/a | yes |
| <a name="input_admin_credentials_username"></a> [admin\_credentials\_username](#input\_admin\_credentials\_username) | Admin username for the OpenShift cluster | `string` | n/a | yes |
| <a name="input_rhcs_token"></a> [rhcs\_token](#input\_rhcs\_token) | RHCS API token for authentication | `string` | n/a | yes |

## Outputs

No outputs.
