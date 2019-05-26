#!/bin/bash

if [ -z "$1" ]
then
    echo "No Slack webhook url supplied."
    exit
fi

if [ -z "$2" ]
then
    echo "No Slack payload supplied."
    exit
fi

SLACK_WEBHOOK=$1
ESCAPED_PAYLOAD=$2

curl -s -H 'Content-type: application/json' -d "$ESCAPED_PAYLOAD" "$SLACK_WEBHOOK"
