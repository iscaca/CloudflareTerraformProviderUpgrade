#!/bin/bash

# Check if resources.txt exists
if [[ ! -f resources.txt ]]; then
  echo "resources.txt file not found!"
  exit 1
fi

# Read each line from resources.txt and run terraform state rm for each
while IFS= read -r resource; do
  echo "Removing resource: $resource"
  terraform state rm "$resource"
done < resources.txt
