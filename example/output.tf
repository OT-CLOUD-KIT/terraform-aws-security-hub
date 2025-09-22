output "securityhub_status" {
  value       = module.security_hub.securityhub_status
  description = "Security Hub status ID"
}

output "enabled_standards" {
  value       = module.security_hub.enabled_standards
  description = "List of enabled security standards"
}

output "sns_topic_arn" {
  value       = module.security_hub.sns_topic_arn
  description = "SNS topic ARN for Security Hub alerts"
}

output "current_region" {
  value       = module.security_hub.current_region
  description = "AWS Region in use"
}

output "current_account" {
  value       = module.security_hub.current_account
  description = "AWS Account ID being used"
}
