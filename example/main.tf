module "security_hub" {
  source = "git@github.com:OT-CLOUD-KIT/terraform-aws-security-hub.git?ref=Feature" 
  enabled                           = var.enabled
  enable_default_standards         = var.enable_default_standards
  enable_standards                 = var.enable_standards
  enabled_standards_arns           = var.enabled_standards_arns
  enable_finding_aggregator        = var.enable_finding_aggregator
  finding_aggregator_linking_mode  = var.finding_aggregator_linking_mode
  finding_aggregator_regions       = var.finding_aggregator_regions
  enable_org_admin                 = var.enable_org_admin
  organization_admin_account_id    = var.organization_admin_account_id
  enable_members                   = var.enable_members
  securityhub_members              = var.securityhub_members
  enable_sns                       = var.enable_sns
  enable_eventbridge_rule          = var.enable_eventbridge_rule
  lambda_arn_to_trigger            = var.lambda_arn_to_trigger
}
