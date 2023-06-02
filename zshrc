#!/bin/bash

function login_aws() {
    aws-mfa --device arn:aws:iam::883938848113:mfa/dle-mfa
}

function assume_role() {
    local ROLE="$1"
    if [[ "$ROLE" == "infosec" ]]; then
        ROLE_ARN="arn:aws:iam::883938848113:role/infosec"
    elif [[ "$ROLE" == "dev" ]]; then
        ROLE_ARN="arn:aws:iam::883938848113:role/dev"
    else
        echo "Invalid role: $ROLE"
        return 1
    fi

    aws sts assume-role --role-arn $ROLE_ARN --role-session-name "$ROLE-session" > tmp
    
    export AWS_ACCESS_KEY_ID=$(grep AccessKeyId tmp | cut -d'"' -f4)
    export AWS_SECRET_ACCESS_KEY=$(grep SecretAccessKey tmp | cut -d'"' -f4)
    export AWS_SESSION_TOKEN=$(grep SessionToken tmp | cut -d'"' -f4)

    rm tmp

    if [ $? -eq 0 ]; then
    	aws sts get-caller-identity
    fi
}

#test
function dev() {
    aws sts assume-role --role-arn arn:aws:iam::883938848113:role/dev --role-session-name dev-clie > tmp

    export AWS_ACCESS_KEY_ID=$(grep AccessKeyId tmp | cut -d'"' -f4)
    export AWS_SECRET_ACCESS_KEY=$(grep SecretAccessKey tmp | cut -d'"' -f4)
    export AWS_SESSION_TOKEN=$(grep SessionToken tmp | cut -d'"' -f4)

    rm tmp
}

function unset_role() {
    unset  AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN
}


alias pip=/usr/local/bin/pip3
