# Program Title: getAccountLockouts.ps1
# Last Updated By: 03/26/2021 - BCC - Joey S. Amalei
# Purpose: Prints a list of domain account lockouts
#
# Notes:
# -(01/20/2022) - Added input prompt to enter target server and admin user for query process
#

# Clear console screen
Clear-Host

Write-Host "============================="
Write-Host "= GET ACCOUNT LOCKOUTS      ="
Write-Host "= ------------------------- ="
Write-Host "=   BLACK CONSTRUCTION CORP ="
Write-Host "============================="
Write-Host
Write-Host

# INPUT
# -----
# Get user input of domain user name to lookup
$computerName = Read-Host "Enter target server computer name"
$userName = Read-Host "Enter admin domain user name"
Write-Host

# PROCESS
# -------
# Perform domain query of users who were locked out:
# Target Domain OU: "Black Construction"
Get-WinEvent -ComputerName $computerName -Credential $userName -FilterHashtable @{logname=’security’; id=4740} | fl

# OUTPUT
# ------
# Display to console screen that report has been printed
Write-Host "------------------"
Write-Host "Process completed."
Write-Host "Good-bye!"
Write-Host
Read-Host "Press enter to continue"