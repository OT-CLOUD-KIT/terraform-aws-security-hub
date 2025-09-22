# Terraform AWS Security Hub

A Terraform module to enable and manage AWS Security Hub with support for:

- Standard subscriptions

- Organization admin account configuration

- Member account invitation/acceptance

- Auto-remediation via EventBridge and Lambda

- SNS topic alerts

___

## Providers

| Name                                              | Version  |
|---------------------------------------------------|----------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.82.2   |
| <a name="terraform_module"></a> [Terraform](Terraform\module) | >= 1.12.1|


## Architecture

<img width="788" height="574" alt="image" src="https://github.com/user-attachments/assets/95d3a3cc-fc92-425c-b3c5-d716d2cfaf10" />



___




## Usage

```hcl
module "security_hub" {
  source = "git::https://github.com/your-org/terraform-aws-securityhub-module.git"

  enabled                         = true
  enable_default_standards        = true
  enable_standards                = true
  enabled_standards_arns          = [
    "arn:aws:securityhub:us-east-1::standards/aws-foundational-security-best-practices/v/1.0.0",
  "arn:aws:securityhub:us-east-1::standards/aws-resource-tagging-standard/v/1.0.0",
  "arn:aws:securityhub:us-east-1::standards/cis-aws-foundations-benchmark/v/1.4.0",
  "arn:aws:securityhub:us-east-1::standards/cis-aws-foundations-benchmark/v/3.0.0"
]
  

  enable_org_admin                = true
  organization_admin_account_id   = "123456789012"

  enable_members                  = true
  securityhub_members             = {
    "111111111111" = { email = "member1@example.com" }
    "222222222222" = { email = "member2@example.com" }
  }

  enable_eventbridge_rule         = true
  lambda_arn_to_trigger           = "arn:aws:lambda:us-east-1:123456789012:function:remediate_findings"

  enable_sns                      = true

  enable_finding_aggregator       = true
  finding_aggregator_linking_mode = "ALL_REGIONS"
}
```
> **Note:**  
> The above example demonstrates how to use the module. All variables, resources, and outputs used here are already defined within this module.


## Resource


| Resource                                                                                                                                                    | Type     |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------- | -------- |
| [aws\_securityhub\_account](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/securityhub_account)                                | Resource |
| [aws\_securityhub\_standards\_subscription](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/securityhub_standards_subscription) | Resource |
| [aws\_securityhub\_finding\_aggregator](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/securityhub_finding_aggregator)         | Resource |
| [aws\_securityhub\_member](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/securityhub_member)                                  | Resource |
| [aws\_sns\_topic](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic)                                                    | Resource |
| [aws\_cloudwatch\_event\_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule)                           | Resource |
| [aws\_cloudwatch\_event\_target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target)                       | Resource |

---




## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enabled"></a> [enabled](#input_enabled) | Enable or disable the module | `bool` | `false` | Yes |
| <a name="input_enable_default_standards"></a> [enable\_default\_standards](#input_enable_default_standards) | Enable default standards like AWS Foundational | `bool` | `true` | Yes |
| <a name="input_enable_standards"></a> [enable\_standards](#input_enable_standards) | Enable specific custom standards | `bool` | `false` | Yes |
| <a name="input_enabled_standards_arns"></a> [enabled\_standards\_arns](#input_enabled_standards_arns) | List of ARNs of standards to subscribe | `list(string)` | `[]` | No |
| <a name="input_enable_org_admin"></a> [enable\_org\_admin](#input_enable_org_admin) | Enable delegated admin setup for org | `bool` | `false` | Yes |
| <a name="input_organization_admin_account_id"></a> [organization\_admin\_account\_id](#input_organization_admin_account_id) | Admin account ID in organization | `string` | `null` | No |
| <a name="input_enable_members"></a> [enable\_members](#input_enable_members) | Enable member account invitation and joining | `bool` | `false` | Yes |
| <a name="input_securityhub_members"></a> [securityhub\_members](#input_securityhub_members) | Map of member accounts and emails | `map(object({ email = string }))` | `{}` | No |
| <a name="input_enable_finding_aggregator"></a> [enable\_finding\_aggregator](#input_enable_finding_aggregator) | Enable findings aggregator setup | `bool` | `false` | Yes |
| <a name="input_finding_aggregator_linking_mode"></a> [finding\_aggregator\_linking\_mode](#input_finding_aggregator_linking_mode) | `ALL_REGIONS` or `SPECIFIED_REGIONS` | `string` | `"ALL_REGIONS"` | No |
| <a name="input_finding_aggregator_regions"></a> [finding\_aggregator\_regions](#input_finding_aggregator_regions) | List of regions if linking mode is specific | `list(string)` | `[]` | No |
| <a name="input_enable_sns"></a> [enable\_sns](#input_enable_sns) | Create SNS topic for alerts | `bool` | `false` | Yes |
| <a name="input_enable_eventbridge_rule"></a> [enable\_eventbridge\_rule](#input_enable_eventbridge_rule) | Create EventBridge rule for automation | `bool` | `false` | Yes |
| <a name="input_lambda_arn_to_trigger"></a> [lambda\_arn\_to\_trigger](#input_lambda_arn_to_trigger) | Lambda ARN to be triggered via EventBridge | `string` | `""` | No |


___

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_securityhub_status"></a> [securityhub\_status](#output\_securityhub\_status) | The ID of the Security Hub account |
| <a name="output_enabled_standards"></a> [enabled\_standards](#output\_enabled_standards) | List of enabled security standards |
| <a name="output_sns_topic_arn"></a> [sns\_topic\_arn](#output\_sns_topic_arn) | ARN of SNS topic for findings |
| <a name="output_current_region"></a> [current\_region](#output\_current_region) | Region where the module is deployed |
| <a name="output_current_account"></a> [current\_account](#output\_current_account) | AWS account ID running the module |

___



## Contributors

- [Piyush Upadhyay](https://github.com/piiiyuushh)
- [Nikita Joshi](https://github.com/jnikita19)

