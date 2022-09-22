terraform {
  required_providers {
    pagerduty = {
      source  = "pagerduty/pagerduty"
      version = "2.6.2"
    }
  }
}



provider "pagerduty" {
  token      = var.api_key
  user_token = var.user_token
}
