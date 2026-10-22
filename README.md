# Cloudflare Enterprise Terraform Starter

A Terraform starter project for deploying common Cloudflare Enterprise security configurations. Originally built to simplify customer POCs and provide a reusable starting point for deployments.

The project helps users new to Cloudflare set up baseline controls and gain visibility into traffic and security events.

> **Legacy reference:** This project uses Cloudflare Terraform Provider `~> 3.0`. The original implementation is intentionally preserved and has **not** been verified against current Cloudflare APIs. Review the configuration and the output of `terraform plan` carefully before attempting deployment.

## What's included

- **Managed WAF:** Executes the Cloudflare Managed Ruleset and OWASP Core Ruleset.
- **Firewall logging:** Logs requests with a Bot Management score below 30 (excluding verified bots), plus requests matching the configured zone hostname.
- **Rate limiting:** Configures a logging rule with a 10-second window and a threshold of 100 requests, counting matching requests with HTTP response codes of 400 or above. This is a visibility rule, **not** a blocking control.
- **Email notifications:** Configures policies for advanced L7 DDoS, L4 DDoS, origin 5xx errors, security-event anomalies, and Universal SSL certificate changes.
- **Zone settings:** Enables TLS 1.3, Automatic HTTPS Rewrites, Full SSL mode, High Security Level, Browser Integrity Check, and Privacy Pass.

## Project files

| File | Purpose |
| --- | --- |
| `cloudflare.tf` | Provider requirement and authentication |
| `variable.tf` | Input variable declarations |
| `wafmanagedrules.tf` | Managed WAF rulesets |
| `firewall.tf` | Firewall filters and logging rules |
| `ratelimiting.tf` | Rate limiting logging rule |
| `notifications.tf` | Account-level notification policies |
| `zone_setting.tf` | Zone security settings |
| `terraform.tfvars.example` | Sample input values (see note below) |

## Original deployment workflow

### Prerequisites

- Terraform CLI
- A Cloudflare account and zone with access to the relevant Enterprise features
- A Cloudflare API token with permissions required by the configured resources

### 1. Clone the repository

```bash
git clone https://github.com/chadismoving/cloudflare-starter.git
cd cloudflare-starter
```

### 2. Configure variables

Copy the example file:

```bash
cp terraform.tfvars.example terraform.tfvars
```

The Terraform configuration declares these inputs:

| Variable | Purpose |
| --- | --- |
| `account_id` | Cloudflare account ID |
| `zone_id` | Cloudflare zone ID |
| `zone_name` | Zone hostname / domain name |
| `api_token` | Cloudflare API token |
| `notification_email` | Email recipient for notification policies |
| `api_key` | Legacy declared variable; not used by the provider block |
| `cf_email` | Legacy declared variable; not used by the provider block |

**Important:** Check that `terraform.tfvars.example` includes every required variable before running Terraform. The original declarations have no defaults, including for `api_key` and `cf_email`. Add missing entries to your *local* `terraform.tfvars` as needed; do not commit real credentials.

### 3. Initialize and review

```bash
terraform init
terraform plan
```

### 4. Apply (only after validation)

```bash
terraform apply
```

These commands describe the original workflow; they are **not** a claim that the configuration deploys successfully with today's APIs. Use a non-production environment and review resource availability, provider compatibility, entitlements, and planned changes first.

## Technical considerations

- Provider v3 and some legacy Cloudflare resources may need migration for modern environments.
- Logging actions are intended for observation; they do not automatically block traffic.
- WAF and notification features depend on account entitlements and permissions.
- The configuration is a POC starter, not a complete production security baseline.
- Keep API credentials, `.tfvars` files containing secrets, and Terraform state out of public repositories. Use appropriate secret and state management for real deployments.

## Possible improvements

- Reusable multi-zone modules
- More flexible notification recipients
- API Shield coverage
- Updated provider support and automated validation

**Status:** Legacy / reference implementation, preserved for technical demonstrations and historical POCs.
