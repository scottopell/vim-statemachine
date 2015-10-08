#!/bin/bash
FILE_CONTENTS=$(cat $1)
curl -s -G "http://localhost:8080/xtext-service/assist?resource=text.statemachine&offset=$2" --data-urlencode "fullText=$FILE_CONTENTS" -X POST | jq -r '.'
