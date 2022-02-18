#!/bin/bash

echo "Beginning storage check..."

exec >> ~/storage_report.txt

echo "Date: $(date)"
echo "------------------"

part=$(df -h | awk '{print $1}' | grep '/dev')

for i in ${part[*]}
do
	checkper=$(df -h | grep $i | awk '{print $5}' | cut -d '%' -f1)

	if [ $checkper -ge 95 ] && [ $checkper -le 100 ]
	then
	    echo "ALERT: $i is $checkper% full! Recommend immediate action!"
	elif [ $checkper -ge 50 ] && [ $checkper -lt 95 ]
	then
	    echo "CAUTION: $i is $checkper% full! Consider freeing up some space."
	elif [ $checkper -lt 50 ]
	then
	    echo "$i is $checkper% full. No action needed."
	else
	    echo "Encountered an error. Status code: $?" >&2
	    exit $?
	fi
done

echo "Storage check complete. Report saved to storage_report.txt." >&2




