#!/usr/bin/env bash
CWD="${0%/*}"

if [[ "$CWD" =~ ^(.*)\.sh$ ]];
then
    CWD="."
fi

echo "Loading env vars..."
source $CWD/env.sh

echo "---------------------------------------------------------------------"
echo "RecordFundsIn PREPARE, RESERVE & COMMIT 100"
echo "---------------------------------------------------------------------"

echo "Sending request for preparing 100 USD to dfsp1 settlement account"
sh -c "curl -X POST \
  http://127.0.0.1:3001/participants/dfsp1/accounts/4 \
  -H 'Content-Type: application/json' \
  -H 'Postman-Token: 8506bf22-d7a2-4609-8047-de768db623fa' \
  -H 'cache-control: no-cache' \
  -d '{
    \"transferId\": \"523ec634-ef48-6575-a6a0-ded2955b8101\",
    \"externalReference\": \"abc123\",
    \"action\": \"recordFundsIn\",
    \"amount\": {
      \"amount\": 100.0000,
      \"currency\": \"USD\"
      
    },
    \"reason\": \"Reason for in flow of funds\",
    \"extensionList\": {
      \"extension\": [
        {
          \"key\": \"extKey1\",
          \"value\": \"extValue1\"
        },
        {
          \"key\": \"extKey2\",
          \"value\": \"extValue2\"
        }
      ]
    }
  }'"
echo 
echo 
echo "Awaiting $SLEEP_FACTOR_IN_SECONDS seconds for the transfer to happen..."
sleep $SLEEP_FACTOR_IN_SECONDS

echo
echo
echo "Completed Scenario 11-1 - Reconciliation transfer prepare, reserve & commit (recordFundsIn)"
echo

sh $CWD/21scenario-part1-results.sh
