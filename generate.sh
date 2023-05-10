#!/bin/sh

# Load the .env file
set -a
. ./.env
set +a

echo '\n$1: Model: '$1
echo '$2: Temperature: '$2
echo '$3: Prompt: '$3

echo '\nGenerating...\n'

curl_command=`cat <<EOS
curl https://api.openai.com/v1/completions \
    -H 'Content-Type: application/json' \
    -H "Authorization: Bearer ${OPENAI_API_KEY}" \
    -d '{
    "model": "$1",
    "prompt": "$3",
    "max_tokens": 2000,
    "temperature": $2
}' \
--insecure
EOS`

echo `eval ${curl_command} | jq '.choices[]'.text`

# sh generate.sh "text-davinci-003" 0.5 "Explain the difference between humanoid robots and autonomous robots."
# sh generate.sh "davinci:ft-personal-2023-05-10-06-07-58" 0.5 "Explain the difference between humanoid robots and autonomous robots."