#!/bin/bash

# Expanded the environment variables list to include mail settings
env_vars=(
  "DB_CONNECTION"
  "DB_HOST"
  "DB_PORT"
  "DB_DATABASE"
  "DB_USERNAME"
  "DB_PASSWORD"
  "MAIL_HOST"
  "MAIL_PORT"
  "MAIL_USERNAME"
  "MAIL_PASSWORD"
  "MAIL_ENCRYPTION"
  "MAIL_FROM_ADDRESS"
)

# Loop through the expected environment variables
for var in "${env_vars[@]}"; do
  # Check if the environment variable is set
  if [ ! -z "${!var}" ]; then
    # Use sed to replace the value in the .env file
    # Pattern explanation:
    # ^: Start of the line
    # ${var}: The environment variable name, e.g., DB_CONNECTION
    # =.*$: Match equals followed by any characters to the end of the line
    # \1: Backreference to the matched variable name, ensuring we only replace the value
    # ${!var}: The value of the environment variable
    # Note: Using | as delimiter in sed to avoid conflict with / in MAIL_FROM_ADDRESS
    sed -i "s|^(${var}=).*$|\1${!var}|" .env
  fi
done
