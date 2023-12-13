module "sns_topic_subscription" {
  source = "github.com/paulo-tinoco/terraform-sns-topic-subscription"

  topics                = var.topics
  queues                = var.queues
  fifo                  = var.fifo
  resource_prefix       = var.resource_prefix
  default_filter_policy = var.default_filter_policy
  account_id            = var.account_id
}
