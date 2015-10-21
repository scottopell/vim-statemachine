#!/bin/bash
echo $1
echo $2
FILE_CONTENTS=$(cat $1)
curl -s -G "http://localhost:8080/xtext-service/assist?resource=text.statemachine&offset=$2" --data-urlencode "fullText=$FILE_CONTENTS" -X POST | jq -r '.'
