# Master toggle
enabled = true

# Security Hub default and custom standards
enable_default_standards = true
enable_standards         = true


enabled_standards_arns = [
  "arn:aws:securityhub:us-east-1::standards/aws-foundational-security-best-practices/v/1.0.0",
  "arn:aws:securityhub:us-east-1::standards/aws-resource-tagging-standard/v/1.0.0",
  "arn:aws:securityhub:us-east-1::standards/cis-aws-foundations-benchmark/v/1.4.0",
  "arn:aws:securityhub:us-east-1::standards/cis-aws-foundations-benchmark/v/3.0.0"
]


# Finding aggregator across regions
enable_finding_aggregator      = true
finding_aggregator_linking_mode = "ALL_REGIONS"
finding_aggregator_regions      = []  # Required only if mode != ALL_REGIONS

# Org-level admin setup
enable_org_admin               = false
organization_admin_account_id = "123456789012"

# Member account invitations
enable_members = false
securityhub_members = {
  "111111111111" = { email = "member1@example.com" }
  "222222222222" = { email = "member2@example.com" }
}

# SNS notifications
enable_sns = true

# EventBridge + Lambda remediation
enable_eventbridge_rule = false
lambda_arn_to_trigger   = "arn:aws:lambda:us-east-1:123456789012:function:securityhub-remediate"
