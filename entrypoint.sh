#!/bin/bash

PROVIDER=$1
LOG_FILE=/root/result.log

echo "==========================="
echo "Running the test provider $PROVIDER ..."
echo "==========================="

touch $LOG_FILE

# Run spoofer
spoofer-prober -v -s1 -r1 -4 --no-tls > $LOG_FILE

# Parse results
AS=$(tail -n 14 $LOG_FILE | grep AS: | cut -d: -f2 | tr -d ' ')
URL_TEST_RESULT=$(tail -n 14 $LOG_FILE | grep https | tr -d ' ')

# Print results
echo "Test finished for AS $AS >>> $URL_TEST_RESULT"

# Send results
# TODO