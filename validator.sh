#!/bin/bash
FILE_CONTENTS=$(cat $1)
curl -s -G "http://localhost:8080/xtext-service/validate?resource=text.statemachine" --data-urlencode "fullText=$FILE_CONTENTS" -X POST | jq -r '.'
