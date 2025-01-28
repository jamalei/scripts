#!/bin/sh

#
# Generate MFA security code
# Date: 01/29/25

# Prompt for 2FA Key to generate security code
# oathtool -b --totp <2fa key>
read -p "Enter the 2FA key: " key

# Write generated key to console screen
oathtool -b --totp $key
