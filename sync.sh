#!/bin/bash

OSX="/Users/ole/Documents/skole/"
SHARE="/Volumes/SHARE/skole/"
LOG="/Users/ole/Library/Logs/sync.log"


date > $LOG

echo -e "\n-> start" >> $LOG
rsync -va $OSX $SHARE >> $LOG
TO=$?
echo -e "-> done" >> $LOG

echo -e "\n<- start" >> $LOG
rsync -va $SHARE $OSX >> $LOG
FROM=$?
echo -e "<- done" >> $LOG

if [ "$TO" != "0" ] && [ "$FROM" != "0" ] ; then
    echo -e "\nerror"
    echo -e "\nTo exit code: $TO , From exit code: $FROM"
    syslog -s -k Facility com.apple.console \
                 Level Error \
                 Sender sync_sh \
                 Message "To exit code: $TO , From exit code: $FROM"
elif [ "$TO" = "0" ] && [ "$FROM" = "0" ] ; then
    echo -e "\nFinished with no errors" >> $LOG
fi

echo -e "\nsync done" >> $LOG

syslog -s -k Facility com.apple.console \
             Level Error \
             Sender sync_sh \
             Message "sync ran"
