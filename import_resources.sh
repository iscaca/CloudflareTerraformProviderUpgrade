#!/bin/bash

# Set environment variables for Cloudflare and AWS
export CLOUDFLARE_API_TOKEN="your_cloudflare_api_token"
export AWS_ACCESS_KEY_ID="your_aws_access_key_id"
export AWS_SECRET_ACCESS_KEY="your_aws_secret_key"

# Check if resources_for_import.txt exists
if [[ ! -f resources_for_import.txt ]]; then
  echo "resources_for_import.txt file not found!"
  exit 1
fi

# Read each line from resources_for_import.txt and run terraform import for each
while IFS= read -r line; do
  resource=$(echo "$line" | awk '{print $1}')
  import_info=$(echo "$line" | awk '{print $2}')

  echo "Importing resource: $resource with info: $import_info"
  terraform import -var="aws_access_key_id=$AWS_ACCESS_KEY_ID" -var="aws_secret_access_key=$AWS_SECRET_ACCESS_KEY" -var="cloudflare_api_token=$CLOUDFLARE_API_TOKEN" "$resource" "$import_info"
done < resources_for_import.txt
