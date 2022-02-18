# Program Title: getUserProperties.ps1
# Last Updated By: 12/28/2020 - BCC - Joey S. Amalei
# Purpose: Prints properites of domain user account
#
# Notes:
# -(1/19/2022) Updated query info for AD user

# Clear console screen
Clear-Host

Write-Host "============================="
Write-Host "= GET USER PROPERTIES       ="
Write-Host "= ------------------------- ="
Write-Host "=   BLACK CONSTRUCTION CORP ="
Write-Host "============================="
Write-Host
Write-Host


# INPUT
# -----
# Get user input of domain user name to lookup
$userName = Read-Host "Enter domain user name"
Write-Host


# PROCESS
# -------
# Perform domain query of users filtering the following:
# Target Domain OU: "Black Construction"
$ErrorLog = $null
Try
{
    $User = Get-ADUser -Filter{SamAccountName -like $userName} -Properties SamAccountName, Comment, Enabled, LastLogonDate, PasswordLastSet, LockedOut -ErrorAction SilentlyContinue
    Write-Host Full Name: $User.Name
    Write-Host User Employee Number: $User.Comment
	Write-Host Enabled Account Status: $User.Enabled 
	Write-Host Last Logon Date: $User.LastLogonDate
	Write-Host Password Last Set: $User.PasswordLastSet
	Write-Host Locked Out Status: $User.LockedOut
}
Catch
{
    $ErrorLog += $_.Exception.Message
    Continue
}
Finally
{
    # OUTPUT
    # ------
    # Display to console screen that report has been printed
    Write-Host "------------------"
    Write-Host "Process completed."
    Write-Host "Good-bye!"
	Write-Host
	Write-Host
	Read-Host "Press any key to continue"
}