#!/bin/sh

EMAIL_ADDRESS="xxx@example.com"

# First of all, run duplicacy backup in the current folder
duplicacy backup
BACKUP_EXIT_STATUS=$?

# Then, check if we are at Tuesday
PRUNE_EXIT_STATUS=0
DOW=$(date +%u)
if [ $DOW -eq 2 ]; then
    duplicacy prune --all -keep 0:360 -keep 30:30 -keep 7:7
    PRUNE_EXIT_STATUS=$?
fi

test $BACKUP_EXIT_STATUS -eq 0 && test $PRUNE_EXIT_STATUS -eq 0
EXIT_STATUS=$?

if [ $EXIT_STATUS -eq 0 ]; then
    echo "Daily backup task executed correctly on Mac Mini!" | \
        mail -s "Mac Mini's backup OK" $EMAIL_ADDRESS
else
    echo "ERROR: backup exited with ${BACKUP_EXIT_STATUS}; prune exited with ${PRUNE_EXIT_STATUS}" | \
        mail -s "Mac Mini's backup ERROR !!!" $EMAIL_ADDRESS
fi

exit $EXIT_STATUS
