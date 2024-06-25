# CloudflareTerraformProviderUpgrade

# Terraform Automation for Cloudflare and AWS Resources

This repository contains scripts to automate the process of managing Cloudflare ruleset resources using Terraform. The process involves fetching Cloudflare ruleset IDs, removing resources, upgrading the Terraform Cloudflare provider, and importing the resources back. This is so usefull for Cloudflare accounts that has numereous of cloudflare_ruleset resources beacause this is needed when you upgrade Cloudflare provider in Terraform to remove and import cloudflare_ruleset resources after upgrading the provider.

## Prerequisites

Ensure you have the following installed and configured:
- Terraform
- CLI
- Cloudflare API Token
- AWS Access Key ID and Secret Access Key(if you are pushing logs to S3 bucket)

- Replace them with your api token that I set within the "fetch_rule_ids.sh" file
- export CLOUDFLARE_API_TOKEN="your_cloudflare_api_token"
- export AWS_ACCESS_KEY_ID="your_aws_access_key_id"
- export AWS_SECRET_ACCESS_KEY="your_aws_secret_key"

## Execution Order

- "list_cloudflare_rulesets.sh" is to list all 'cloudflare_ruleset' resources and save them in a file.
- "fetch_rule_ids.sh" is to  fetch the ruleset IDs and save them in a seperate file.
- "remove_resources.sh" is to remove the resources that we listed via the "list_cloudflare_rulesets.sh".
- We need to modify the provider configuration's version from 3x to 4x both root and child terraform configuration then run "terraform init -upgrade".
- "import_reesources.sh" is to import resources that we remove via "remove_resources.sh".