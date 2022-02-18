#!/bin/bash

echo "Beginning storage check..."

exec >> ~/storage_report.txt

echo "Date: $(date)"
echo "------------------"

part=/dev/sda1
checkper=$(df -h | grep $part | awk '{print $5}' | cut -d '%' -f1)

echo "$part is $checkper% full."

echo "Storage check complete. Report saved to storage_report.txt." >&2




