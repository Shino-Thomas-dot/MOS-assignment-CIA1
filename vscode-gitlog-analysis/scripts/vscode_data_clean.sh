#!/bin/bash
# File name for the cleaned dataset
OUTPUT_FILE="vscode_gitlog.csv"

# Add header row
echo "commit_hash,author_name,commit_date,commit_message" > "$OUTPUT_FILE"

# Append Git log data in CSV format
git log \
  --pretty=format:'%H,%an,%ad,%s' \
  --date=short \
  >> "$OUTPUT_FILE"

