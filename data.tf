data "aws_cloudwatch_event_source" "zendesk_partner" {
  name_prefix = var.event_bus.partner_name
}

data "aws_cloudwatch_event_bus" "zendesk_partner" {
  for_each = toset(var.event_bus.create_event_bus ? [] : [var.event_bus.partner_name])

  name = each.value
}

data "aws_iam_policy_document" "sns_topic_policy" {
  statement {
    effect  = "Allow"
    actions = ["SNS:Publish"]

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }

    resources = local.sns_topics_arn
  }

  depends_on = [module.sns_topic_subscription]
}
