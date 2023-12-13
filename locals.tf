locals {
  event_bus_arn = var.event_bus.create_event_bus ? aws_cloudwatch_event_bus.zendesk_partner[var.event_bus.partner_name].arn : data.aws_cloudwatch_event_bus.zendesk_partner[var.event_bus.partner_name].arn
}
