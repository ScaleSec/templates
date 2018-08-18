#!/bin/sh

# usage:
# $ ./list_user_permissions.sh [user_email]

ORG_ID="[insert your org id]"
PROJ_ID="scalesec-dev"

# paramaterize username
#JQ_STRING=".bindings[] | select (.members[]==\"user:$1\") | .role"

# find roles bound to this user
ROLES=`gcloud organizations get-iam-policy ${ORG_ID} --format=json | jq --arg USER "user:$1" -r '.bindings[] | select (.members[]==$USER) | .role'`

# list permission for each role and sort unique
for ROLE in ${ROLES}; do
	gcloud iam roles describe ${ROLE} --format=json | jq '.includedPermissions[]'; 
done | sort -u
