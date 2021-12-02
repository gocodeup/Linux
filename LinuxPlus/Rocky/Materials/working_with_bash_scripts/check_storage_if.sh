#!/bin/bash

echo "Beginning storage check..."

exec >> ~/storage_report.txt

echo "Date: $(date)"
echo "------------------"

part=/dev/sda1
checkper=$(df -h | grep $part | awk '{print $5}' | cut -d '%' -f1)

if [ $checkper -ge 95 ] && [ $checkper -le 100 ]
then
    echo "ALERT: $part is $checkper% full! Recommend immediate action!"
elif [ $checkper -ge 50 ] && [ $checkper -lt 95 ]
then
    echo "CAUTION: $part is $checkper% full! Consider freeing up some space."
elif [ $checkper -lt 50 ]
then
    echo "$part is $checkper% full. No action needed."
else
    echo "Encountered an error. Status code: $?" >&2
    exit $?
fi

echo "Storage check complete. Report saved to storage_report.txt." >&2




