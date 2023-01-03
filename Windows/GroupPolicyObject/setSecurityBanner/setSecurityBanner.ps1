# Program Title: setSecurityBanner.ps1
# Last Updated By: 01/03/2023 - BCC - Joey S. Amalei
# Purpose: Sets security banner logon title and text
#
# Notes:
# -(01/03/2023) Initial creation

# Clear console screen
Clear-Host

Write-Host "╔═══════════════════════════╗"
Write-Host "║ Set Security Banner       ║"
Write-Host "╠═══════════════════════════╣"
Write-Host "║   BLACK CONSTRUCTION CORP ║"
Write-Host "╚═══════════════════════════╝"
Write-Host
Write-Host


# INPUT
# -----
# Get user input to add/remove security logon banner

Write-Host "TITLE: IMPORTANT NOTICE"
Write-Host
Write-Host "TEXT: This computer system is the property of Black Construction Corporation, a Tutor Perini Company. It is for authorized use only. By using this system, all users acknowledge notice of, and agree to comply with, the Black Construction Corporation's Acceptable Use Policy (AUP). Unauthorized or improper use of this system may result in administrative disciplinary action, civil charges/criminal penalties, and/or other sanctions as set forth in the Black Construction Corporation's AUP. By continuing to use this system you indicate your awareness of and consent to these terms and conditions of use.
It is the user’s responsibility to LOG OFF IMMEDIATELY if you do not agree to the conditions stated in this notice."
Write-Host
$userChoice = Read-Host "Would you like to apply the security banner? (Y/N)"
Write-Host
Write-Host


# PROCESS
# -------
# Perform requested process
# Yes - Appy security logon banner
# No - Remove security logon banner
$ErrorLog = $null
Try
{
    if ($userChoice -contains "Y")
	{
		Write-Host Selected Choice: $userChoice
		Write-Host "Applying banner..."
		Write-Host
		# Security Logon Title
		Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System -Name legalnoticecaption -Value "IMPORTANT NOTICE" -Force
		# Security Logon Text
		Set-ItemProperty -Path HKLM:SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System -Name legalnoticetext -Value "This computer system is the property of Black Construction Corporation, a Tutor Perini Company. It is for authorized use only. By using this system, all users acknowledge notice of, and agree to comply with, the Black Construction Corporation's Acceptable Use Policy (AUP). Unauthorized or improper use of this system may result in administrative disciplinary action, civil charges/criminal penalties, and/or other sanctions as set forth in the Black Construction Corporation's AUP. By continuing to use this system you indicate your awareness of and consent to these terms and conditions of use. It is the user’s responsibility to LOG OFF IMMEDIATELY if you do not agree to the conditions stated in this notice." -Force
	}
	else
	{
		Write-Host Selected Choice: $userChoice
		Write-Host "Removing banner..."
		Write-Host
		# Security Logon Title
		Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System -Name legalnoticecaption -Value "" -Force
		# Security Logon Text
		Set-ItemProperty -Path HKLM:SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System -Name legalnoticetext -Value "" -Force
	}
	
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