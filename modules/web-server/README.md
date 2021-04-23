web-server module
=================

It's a web-server. That's it.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| ami\_id | n/a | `any` | n/a | yes |
| environment\_name | environment identifier | `any` | n/a | yes |
| instance\_size | ec2 instance size | `string` | `"t2.micro"` | no |
| server\_http\_port | port where the http server is running | `number` | `80` | no |
| subnet | subnet in which to place the instance | `any` | n/a | yes |
| tags | A map of tags to add to all resourcess | `map(string)` | `{}` | no |
| vpc\_id | the id for the vpc in which the security group should be created | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| public\_ip | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
