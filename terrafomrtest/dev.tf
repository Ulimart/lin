
resource "pagerduty_team" "devops" {
  name        = "DevOps"
  description = "The best DevOps team"
}

resource "pagerduty_user" "devops-user1" {
  name  = "sam"
  email = "sam@example.com"
  teams = [pagerduty_team.devops.id]
  role  = "observer"
}

#Phone number Premium-rate numbers are not supported for trial accounts
# resource "pagerduty_user_contact_method" "phone" {
#   user_id      = pagerduty_user.devops-user1.id
#   type         = "phone_contact_method"
#   country_code = "+1"
#   address      = "2025550199"
#   label        = "Work"
# }

resource "pagerduty_user" "devops-user2" {
  name  = "miguel"
  email = "miguel@example.name"
  teams = [pagerduty_team.devops.id]
  role  = "admin"
}

resource "pagerduty_user" "devops-user3" {
  name  = "Paul"
  email = "paul@example.name"
  teams = [pagerduty_team.devops.id]
  role  = "user"
}


resource "pagerduty_escalation_policy" "example" {
  name = "DevOps Escalation Policy"


  rule {
    escalation_delay_in_minutes = 10
    target {
      type = "user_reference"
      id   = pagerduty_user.devops-user1.id
    }
    target {
      type = "user_reference"
      id   = pagerduty_user.devops-user2.id
    }
  }
}

resource "pagerduty_service" "Devops-service" {
  name                    = "Devops-service"
  description             = "This is the devops serivce"
  auto_resolve_timeout    = 3600
  acknowledgement_timeout = 3600
  escalation_policy       = pagerduty_escalation_policy.example.id
  alert_creation          = "create_alerts_and_incidents"
}
