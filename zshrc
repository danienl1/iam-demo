#!/bin/bash

export AWS_MFA_DEVICE=mfa/user
export AWS_ACCOUNT_ID=1234

function login_aws() {
	aws-mfa --device $AWS_MFA_DEVICE
}

function assume_role() {
    local ROLE="$1"
    if [[ "$ROLE" == "infosec" ]]; then
        ROLE_ARN="arn:aws:iam::$AWS_ACCOUNT_ID:role/infosec"
    elif [[ "$ROLE" == "dev" ]]; then
        ROLE_ARN="arn:aws:iam::$AWS_ACCOUNT_ID:role/dev"
    else
        echo "invalid role: $ROLE"
        return 1
    fi

    aws sts assume-role --role-arn $ROLE_ARN --role-session-name "$ROLE-session"

    if [ $? -eq 0 ]; then
    	aws sts get-caller-identity
    fi
}


alias pip=/usr/local/bin/pip3
