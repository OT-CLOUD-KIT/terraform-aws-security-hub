variable "enabled" {
  description = "Enable the Security Hub module"
  type        = bool
  default     = true
}

variable "enable_default_standards" {
  description = "Enable default AWS standards"
  type        = bool
  default     = true
}

variable "enable_standards" {
  description = "Enable custom Security Hub standards"
  type        = bool
  default     = false
}

variable "enabled_standards_arns" {
  description = "List of custom standard ARNs to enable"
  type        = list(string)
  default     = []
}

variable "enable_finding_aggregator" {
  description = "Enable finding aggregator"
  type        = bool
  default     = false
}

variable "finding_aggregator_linking_mode" {
  description = "Linking mode for finding aggregator"
  type        = string
  default     = "ALL_REGIONS"
}

variable "finding_aggregator_regions" {
  description = "Specific regions for finding aggregator (if not ALL_REGIONS)"
  type        = list(string)
  default     = []
}

variable "enable_org_admin" {
  description = "Enable organization admin account setup"
  type        = bool
  default     = false
}

variable "organization_admin_account_id" {
  description = "Account ID of the organization admin"
  type        = string
  default     = null
}

variable "enable_members" {
  description = "Enable Security Hub members"
  type        = bool
  default     = false
}

variable "securityhub_members" {
  description = "Map of member accounts with emails"
  type = map(object({
    email = string
  }))
  default = {}
}

variable "enable_sns" {
  description = "Enable SNS topic for alerts"
  type        = bool
  default     = false
}

variable "enable_eventbridge_rule" {
  description = "Enable EventBridge rule for findings"
  type        = bool
  default     = false
}

variable "lambda_arn_to_trigger" {
  description = "ARN of the Lambda function for auto-remediation"
  type        = string
  default     = ""
}
