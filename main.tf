

data "aws_partition" "this" {}
data "aws_caller_identity" "this" {}
data "aws_region" "this" {}

resource "aws_securityhub_account" "account" {
  count = var.enabled ? 1 : 0
  enable_default_standards = var.enable_default_standards
}

resource "aws_securityhub_standards_subscription" "standards_subscription" {
  for_each     = var.enabled && var.enable_standards ? toset(var.enabled_standards_arns) : []
  standards_arn = each.value
  depends_on   = [aws_securityhub_account.account]
}

resource "aws_securityhub_finding_aggregator" "aggregator" {
  count = var.enabled && var.enable_finding_aggregator ? 1 : 0

  linking_mode      = var.finding_aggregator_linking_mode
  specified_regions = var.finding_aggregator_linking_mode == "ALL_REGIONS" ? null : var.finding_aggregator_regions

  depends_on = [aws_securityhub_account.account]
}

resource "aws_securityhub_organization_admin_account" "org_admin" {
  count             = var.enabled && var.enable_org_admin && var.organization_admin_account_id != null ? 1 : 0
  admin_account_id  = var.organization_admin_account_id
}

resource "aws_securityhub_organization_configuration" "org_config" {
  count       = var.enabled && var.enable_org_admin && var.organization_admin_account_id != null ? 1 : 0
  auto_enable = true

  depends_on = [aws_securityhub_organization_admin_account.org_admin]
}

resource "aws_securityhub_member" "members" {
  for_each  = var.enabled && var.enable_members && var.securityhub_members != null ? var.securityhub_members : {}

  account_id = each.key
  email      = each.value.email
  invite     = true

  depends_on = [aws_securityhub_account.account]
}

resource "aws_securityhub_invite_accepter" "invite_accepter" {
  for_each  = var.enabled && var.enable_members && var.securityhub_members != null ? var.securityhub_members : {}

  master_id  = var.organization_admin_account_id

  depends_on = [aws_securityhub_member.members]
}

# Optional SNS Notification for Findings
resource "aws_sns_topic" "securityhub_alerts" {
  count = var.enabled && var.enable_sns ? 1 : 0
  name  = "securityhub-alerts"
}


# Optional EventBridge Rule for Auto-remediation
resource "aws_cloudwatch_event_rule" "findings_rule" {
  count       = var.enabled && var.enable_eventbridge_rule ? 1 : 0
  name        = "securityhub-findings-rule"
  description = "Capture Security Hub findings"
  event_pattern = jsonencode({
    "source": ["aws.securityhub"],
    "detail-type": ["Security Hub Findings - Imported"]
  })
}

resource "aws_cloudwatch_event_target" "lambda_target" {
  count     = var.enabled && var.enable_eventbridge_rule ? 1 : 0
  rule      = aws_cloudwatch_event_rule.findings_rule[0].name
  target_id = "securityhub-remediation"
  arn       = var.lambda_arn_to_trigger
}
