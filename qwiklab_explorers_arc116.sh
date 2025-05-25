#!/bin/bash
BLACK_TEXT=$'\033[0;90m'
RED_TEXT=$'\033[0;91m'
GREEN_TEXT=$'\033[0;92m'
YELLOW_TEXT=$'\033[0;93m'
BLUE_TEXT=$'\033[0;94m'
MAGENTA_TEXT=$'\033[0;95m'
CYAN_TEXT=$'\033[0;96m'
WHITE_TEXT=$'\033[0;97m'
RESET_FORMAT=$'\033[0m'
BOLD_TEXT=$'\033[1m'
UNDERLINE_TEXT=$'\033[4m'

clear

echo -n "${GREEN_TEXT}${BOLD_TEXT}Enter bucket_name : ${RESET_FORMAT}"
read bucket_name


cat > redact-request.json <<EOF
{
  "item": {
    "value": "Please update my records with the following information:\n Email address: foo@example.com,\nNational Provider Identifier: 1245319599"
  },
  "deidentifyConfig": {
    "infoTypeTransformations": {
      "transformations": [{
        "primitiveTransformation": {
          "replaceWithInfoTypeConfig": {}
        }
      }]
    }
  },
  "inspectConfig": {
    "infoTypes": [{
        "name": "EMAIL_ADDRESS"
      },
      {
        "name": "US_HEALTHCARE_NPI"
      }
    ]
  }
}
EOF


curl -s \
  -H "Authorization: Bearer $(gcloud auth print-access-token)" \
  -H "Content-Type: application/json" \
  https://dlp.googleapis.com/v2/projects/$DEVSHELL_PROJECT_ID/content:deidentify \
  -d @redact-request.json -o redact-response.txt

echo
echo "${BLUE_TEXT}${BOLD_TEXT} Uploading the de-identified output to your Cloud Storage bucket...${RESET_FORMAT}"
gsutil cp redact-response.txt gs://$bucket_name

echo
echo "${RED_TEXT}${BOLD_TEXT}|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||${RESET_FORMAT}"
echo "${GREEN_TEXT}${BOLD_TEXT}        NOW FOLLOW NEXT STEPS CAREFULLY FROM THE VIDEO      ${RESET_FORMAT}"
echo "${RED_TEXT}${BOLD_TEXT}|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||${RESET_FORMAT}"
echo

echo "${GREEN_TEXT}${BOLD_TEXT} CLICK ON THAT LINK TO OPEN : ${BLUE_TEXT}https://console.cloud.google.com/security/sensitive-data-protection/landing/configuration/templates/deidentify?project=${DEVSHELL_PROJECT_ID}${RESET_FORMAT}"


echo
echo "${GREEN_TEXT}${BOLD_TEXT} IF IT'S HELPS YOU THEN SUBSCRIBE TO QWIKLAB EXPLORERS! ${RESET_FORMAT}"
echo "${BLUE_TEXT}${BOLD_TEXT}${UNDERLINE_TEXT}https://www.youtube.com/@Arcade61432${RESET_FORMAT}"
echo
