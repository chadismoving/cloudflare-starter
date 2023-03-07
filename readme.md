	A simple, easy to deploy terraform for user new to Cloudflare Enterprise
	Aim for the user who have no experience on using Cloudflare or want to have some basic setting and visibility
	This terraform will deploy rules and enable some settings, including
		Firewall event with log action
		Bot Score with log action
		Rate Limiting with log action
		Enable Managed Rulesets (CF Managed + OWASP)
		Notification with email integration
			Advanced L7 DDoS Attack
			Origin 5xx error
			L4 DDoS Attack
			Advanced WAF Alert
			Universal SSL certificate changes
		Some zone level setting
	How to Use?
		Install Terraform
        https://developer.hashicorp.com/terraform/tutorials/certification-associate-tutorials/install-cli
		
        Create API Token
        https://developers.cloudflare.com/fundamentals/api/get-started/create-token/
		
        Git Pull or download this repo to the folder
		Prepare Terraform environment with `terraform init`
		Fill in the information and credential in file terraform.tfvars
		Run `terraform plan` to verify the change or `terraform apply` to update to the environment
	Foreseeable Improvement
		Using list for zone and email notification
		Implementation for API Shield
		Add functions not yet available in Terraform (i.e. Page Shield)
		More secure way to store Cloudflare credential
