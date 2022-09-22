

resource "pagerduty_team" "sre" {
  name        = "SRE"
  description = "Super SRE team"
}

resource "pagerduty_user" "this" {
  count = length(var.pagerduty_users)
  name  = var.pagerduty_users[count.index]["name"]
  email = var.pagerduty_users[count.index]["email"]
  role  = var.pagerduty_users[count.index]["role"]
}




resource "pagerduty_escalation_policy" "sre-policy" {
  name = "SRE Escalation Policy"

  rule {
    escalation_delay_in_minutes = 10

    target {
      type = "user_reference"
      id   = pagerduty_user.this[0].id
    }
    target {
      type = "user_reference"
      id   = pagerduty_user.this[1].id
    }
  }
}

resource "pagerduty_service" "sre-service" {
  name                    = "SRE-service"
  description             = "This is the devops serivce"
  auto_resolve_timeout    = 14400
  acknowledgement_timeout = 600
  escalation_policy       = pagerduty_escalation_policy.sre-policy.id
  alert_creation          = "create_alerts_and_incidents"
}




# resource "pagerduty_slack_connection" "SRE-test" {
#   source_id = pagerduty_service.sre-service.id
#   source_type = "service_reference"
#   workspace_id = "T043L4U0TSL"
#   channel_id = "C043VHX4S7J"
#   notification_type = "responder"
#   config {
#     events = [
#       "incident.triggered",
#       "incident.acknowledged",
#       "incident.escalated",
#       "incident.resolved",
#       "incident.reassigned",
#       "incident.annotated",
#       "incident.unacknowledged",
#       "incident.delegated",
#       "incident.priority_updated",
#       "incident.responder.added",
#       "incident.responder.replied",
#       "incident.status_update_published",
#       "incident.reopened"
#     ]
#   }
# }

# Error: POST API call to https://app.pagerduty.com/integration-slack/workspaces/T043L4U0TSL/connections failed 404 Not Found. Code: 0, Errors: <nil>, Message: The PagerDuty has not been connected to this workspace. Please complete the installation and try again.