resource "cloudflare_zone_settings_override" "zone-default" {
  zone_id = var.zone_id
  settings {
    tls_1_3                  = "on"
    automatic_https_rewrites = "on"
    ssl                      = "full"
    security_level           = "high"
    browser_check           = "on"
    privacy_pass           = "on"
  }
}


