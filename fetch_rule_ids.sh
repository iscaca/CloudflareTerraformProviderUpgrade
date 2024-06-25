#!/bin/bash

# Check if resources.txt exists
if [[ ! -f resources.txt ]]; then
  echo "resources.txt file not found!"
  exit 1
fi

# Output file for resources with rule_id in the desired format
output_file="resources_for_import.txt"
echo -n "" > $output_file

# Function to get main rule_id and zone_id from terraform state show output
get_main_rule_and_zone_id() {
  resource=$1
  state_output=$(terraform state show "$resource")
  zone_id=$(echo "$state_output" | grep -E 'zone_id\s*=' | awk '{print $3}' | tr -d '"')
  main_rule_id=$(echo "$state_output" | grep -E 'id\s*=' | head -n 1 | awk '{print $3}' | tr -d '"')
  echo "$zone_id/$main_rule_id"
}

# Read each line from resources.txt and fetch zone_id/main_rule_id
while IFS= read -r resource; do
  echo "Fetching zone_id and main rule_id for resource: $resource"
  zone_and_main_rule_id=$(get_main_rule_and_zone_id "$resource")
  
  if [[ -z $zone_and_main_rule_id ]]; then
    echo "Failed to fetch zone_id and main rule_id for resource: $resource"
    continue
  fi

  echo "$resource zone/$zone_and_main_rule_id" >> $output_file
done < resources.txt

echo "Resources for import saved to $output_file"
