output "securityhub_status" {
  value       = try(aws_securityhub_account.account[0].id, null)
  description = "Security Hub status ID"
}

output "enabled_standards" {
  value       = keys(aws_securityhub_standards_subscription.standards_subscription)
  description = "List of enabled security standards"
}

output "sns_topic_arn" {
  value       = try(aws_sns_topic.securityhub_alerts[0].arn, null)
  description = "SNS topic ARN for Security Hub alerts"
}

output "current_region" {
  value = data.aws_region.this.id
}

output "current_account" {
  value = data.aws_caller_identity.this.account_id
}
