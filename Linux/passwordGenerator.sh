#!/usr/bin/bash

#
# Password Generator Script
# Date: 01/24/2025
# Author By: Nicolas Grogg (Etica Inc.)
#

# Create length of password string to create
length=$1
if [ -z $length ]; then
	length=12
fi

# Assign psuedo-random characters
pass=$(date +%s | sha256sum | base64 | head -c $length)
pass+=$(((RANDOM%1000+1)))
pass+="!"

# Print password to console output
echo $pass
