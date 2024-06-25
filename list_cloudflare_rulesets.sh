#!/bin/bash

# List Cloudflare ruleset resources and save to resources.txt
terraform state list | grep 'cloudflare_ruleset' > resources.txt

echo "Cloudflare rulesets saved to resources.txt"
