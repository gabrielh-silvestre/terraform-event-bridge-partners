locals {
  event_bus_arn = var.event_bus.create_event_bus ? aws_cloudwatch_event_bus.zendesk_partner[var.event_bus.partner_name].arn : data.aws_cloudwatch_event_bus.zendesk_partner[var.event_bus.partner_name].arn

  sns_topics = {
    for topic in module.sns_topic_subscription.local_subscriptions : topic.topic_name => topic
  }

  sns_topics_arn = toset([
    for topic in module.sns_topic_subscription.local_subscriptions : topic.topic_arn
  ])
}
