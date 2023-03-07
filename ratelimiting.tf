resource "cloudflare_ruleset" "zone_rl_custom_response" {
  zone_id     = var.zone_id
  name        = "Rate limiting for >400 response"
  description = ""
  kind        = "zone"
  phase       = "http_ratelimit"

  rules {
    action = "log"
    ratelimit {
      characteristics = ["ip.src", "cf.colo.id"]
      period = 10
      requests_per_period = 100
      mitigation_timeout = 60
      counting_expression = "(http.host contains \"${var.zone_name}\") and (http.response.code ge 400)"
    }
    expression = "(http.host contains \"${var.zone_name}\")"
    description = "Rate limit requests to \"${var.zone_name}\" when exceeding the threshold of >400 responses"
    enabled = true
  }
}