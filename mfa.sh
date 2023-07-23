#!/bin/bash

## A bash script to get the current profile a session token for aws.
## Make sure to export AWS_PROFILE= to use the corrent profile
## call the script using source ./aws-mfa.sh  (so the export will take effect in your shell)

# Remove current credentials
echo "Removing current session credentials..."
export AWS_ACCESS_KEY_ID=
export AWS_SECRET_ACCESS_KEY=
export AWS_SESSION_TOKEN=

if [[ -z $AWS_PROFILE ]]; then
  echo "AWS_PROFILE is empty, will use the default profile"
fi

# Read user input in the Bash script
echo -n "Enter the MFA name: "
read mfa_name

echo -n "Enter the MFA code: "
read mfa_code

# Get the account id
account=$(aws sts get-caller-identity --query "Account" --output text) 

# Generate the session token
output=$(aws sts get-session-token --serial-number arn:aws:iam::$account:mfa/$mfa_name --token-code $mfa_code --duration-seconds 86400)

# Check if the variable is empty
if [[ -n "$output" ]]; then
    # Source the output to update the environment variables in the current shell
    access_key=$(echo "$output" | jq -r '.Credentials.AccessKeyId')
    secret_key=$(echo "$output" | jq -r '.Credentials.SecretAccessKey')
    session_token=$(echo "$output" | jq -r '.Credentials.SessionToken')
    export AWS_ACCESS_KEY_ID=$access_key
    export AWS_SECRET_ACCESS_KEY=$secret_key
    export AWS_SESSION_TOKEN=$session_token
    echo "AWS MFA Success"
else
	# Echo the error
	echo ""
	echo "AWS MFA Failure"
fi

