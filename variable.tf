# variables.tf
variable "enabled" {
  type        = bool
  description = "Enable the Security Hub setup"
  default     = true
}

variable "enable_default_standards" {
  type        = bool
  description = "Enable AWS Foundational Best Practices"
  default     = true
}

variable "enable_standards" {
  type        = bool
  description = "Enable Security Hub compliance standards"
  default     = true
}

variable "enabled_standards_arns" {
  type        = list(string)
  description = "List of standard ARNs to enable"
  default     = [
    "arn:aws:securityhub:::standards/cis-aws-foundations-benchmark/v/1.2.0",
    "arn:aws:securityhub:::standards/aws-foundational-security-best-practices/v/1.0.0"
  ]
}

variable "enable_finding_aggregator" {
  type        = bool
  description = "Enable finding aggregator"
  default     = false
}

variable "finding_aggregator_linking_mode" {
  type        = string
  description = "Linking mode for finding aggregator"
  default     = "ALL_REGIONS"
}

variable "finding_aggregator_regions" {
  type        = list(string)
  description = "Regions to aggregate findings from"
  default     = []
}

variable "enable_org_admin" {
  type        = bool
  description = "Enable org admin configuration"
  default     = false
}

variable "organization_admin_account_id" {
  type        = string
  description = "ID of Security Hub admin account for AWS Organization"
  default     = null
}

variable "enable_members" {
  type        = bool
  description = "Enable member account invitations"
  default     = false
}

variable "securityhub_members" {
  type        = map(object({ email = string }))
  description = "Member accounts to invite"
  default     = {}
}

variable "enable_sns" {
  type        = bool
  description = "Whether to create SNS topic for findings"
  default     = false
}

variable "enable_eventbridge_rule" {
  type        = bool
  description = "Whether to create EventBridge rule for findings"
  default     = false
}

variable "lambda_arn_to_trigger" {
  type        = string
  description = "Lambda function ARN to trigger for remediation"
  default     = ""
}
