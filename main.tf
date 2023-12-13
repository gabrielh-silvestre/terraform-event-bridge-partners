resource "aws_cloudwatch_event_bus" "zendesk_partner" {
  for_each = toset(var.event_bus.create_event_bus ? [var.event_bus.partner_name] : [])

  name              = data.aws_cloudwatch_event_source.zendesk_partner.name
  event_source_name = data.aws_cloudwatch_event_source.zendesk_partner.name
}

resource "aws_cloudwatch_event_permission" "DevAccountAccess" {
  principal    = var.account_id
  statement_id = "AccountAccessToZendeskPartner"
}

resource "aws_cloudwatch_event_rule" "zendesk" {
  name        = var.event_rule.name
  description = "Send Zendesk events to SNS"

  event_bus_name = local.event_bus_arn
  event_pattern  = var.event_rule.event_pattern
}

resource "aws_cloudwatch_event_target" "sns" {
  for_each = local.sns_topics

  rule           = aws_cloudwatch_event_rule.zendesk.name
  target_id      = "SendToSNS"
  arn            = each.value.topic_arn
  event_bus_name = local.event_bus_arn
}

resource "aws_sns_topic_policy" "default" {
  for_each = local.sns_topics

  arn    = each.value.topic_arn
  policy = data.aws_iam_policy_document.sns_topic_policy.json
}
