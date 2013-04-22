#!/bin/bash

fileName="$1"
deviceFile="$2"


if [ -f $fileName ]
then
        if [ -e $deviceFile ]
        then
                fileInodeNum=`ls -i $1 |awk '{print $1}'`
                fileCrTime=`debugfs -R "stat <$fileInodeNum>" $deviceFile 2>/dev/null | awk -F -- '/crtime/ {print $2}'`
                echo $fileCrTime
                exit 0
        else
                echo "device doesn't exist"
        fi
else
        echo "wrong syntax: eg.: ./icreatedate <file_name> <device>"
fi
