resource "cloudflare_notification_policy" "l7_ddos" {
  account_id  = var.account_id
  name        = "Under L7 DoS Attack"
  description = "Alert for zones under L7 DDoS Attack"
  enabled     = true
  alert_type  = "advanced_ddos_attack_l7_alert"

  email_integration {
    id = var.notification_email
  }

    filters {
    target_zone_name = [var.zone_name]
  }
}

resource "cloudflare_notification_policy" "origin_error" {
  account_id  = var.account_id
  name        = "Origin 5xx error Breach 99.9% SLO"
  description = "Alert when Cloudflare receive 5xx from origin"
  enabled     = true
  alert_type  = "http_alert_origin_error"

  email_integration {
    id = var.notification_email
  }

    filters {
    zones = [var.zone_id]
    slo = [99.9]
  }
}

resource "cloudflare_notification_policy" "dos_attack_l4" {
  account_id  = var.account_id
  name        = "Under L4 DoS Attack"
  description = "Alert for zones under L4 DoS Attack"
  enabled     = true
  alert_type  = "dos_attack_l4"

  email_integration {
    id = var.notification_email
  }
} 

resource "cloudflare_notification_policy" "universal_ssl_event_type" {
  account_id  = var.account_id
  name        = "Notification for Universal Certifiates"
  description = "Alert for zones universal certificates changes"
  enabled     = true
  alert_type  = "universal_ssl_event_type"

  email_integration {
    id = var.notification_email
  }
} 

resource "cloudflare_notification_policy" "advanced_waf" {
  account_id  = var.account_id
  name        = "Spikes receive from Cloudflare"
  description = "Alert when spikes in specific security services"
  enabled     = true
  alert_type  = "clickhouse_alert_fw_ent_anomaly"

  email_integration {
    id = var.notification_email
  }

    filters {
    zones = [var.zone_id]
    services = ["country","waf","firewallrules","ratelimit","securitylevel","ip","validation","bic","hot","uablock","zonelockdown","iprange","asn","firewallCustom","firewallManaged","dlp"]
  }
}