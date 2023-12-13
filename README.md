# Terraform Event Bridge Partners

Terraform module to integrate AWS Event Bridge Partners with SNS Topics and SQS Queues.

## Usage

```hcl
module "terraform-event-bridge-partners" {
  source = "github.com/gabrielh-silvestre/terraform-event-bridge-partners"

  account_id = "000000000000"
  event_bus = {
    partner_name = "aws.partner/zendesk.com/00000000/default"
  }

  event_rule = {
    name = "zendesk"
    event_pattern = jsonencode({
      "source" : [{ "prefix" : "aws.partner/zendesk.com" }]
    })
  }

  topics = [
    {
      name = "event_bridge_topic"
    }
  ]

  queues = [
    {
      name = "event_bridge"
      topics_to_subscribe = [
        {
          name = "event_bridge_topic"
        }
      ]
    }
  ]
}
```
