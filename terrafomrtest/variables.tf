variable "api_key" {}
variable "user_token" {}

variable "pagerduty_users" {
  default = [
    {
      name  = "uli"
      email = "uli@example.name"
      role  = "observer"
    },
    {
      name  = "mario"
      email = "mario@example.name"
      role  = "admin"
    }
  ]
}
