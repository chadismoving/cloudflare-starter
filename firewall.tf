resource "cloudflare_filter" "bot-log" {
  zone_id = var.zone_id
  description = "Log Bot Traffic"
  expression  = "(cf.bot_management.score lt 30 and not cf.bot_management.verified_bot)"
}

resource "cloudflare_firewall_rule" "bot-log" {
  zone_id = var.zone_id
  description = "Log Bot Traffic"
  filter_id   = cloudflare_filter.bot-log.id
  action      = "log"
  priority = 1
}

resource "cloudflare_filter" "log-all" {
  zone_id = var.zone_id
  description = "Log all traffic to zone"
  expression  = "(http.host contains \"${var.zone_name}\")"

}

resource "cloudflare_firewall_rule" "log-all" {
  zone_id = var.zone_id
  description = "Log all traffic to zone"
  filter_id   = cloudflare_filter.log-all.id
  action      = "log"
  priority = 2
}