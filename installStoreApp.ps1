# Program Title: installStoreApp.ps1
# Last Updated By: 02/22/2021 - BCC - Joey S. Amalei
# Purpose: Script to run and install MS Store App manually
#

# Clear console screen
Clear-Host

Write-Host "==============================="
Write-Host "= INSTALL MICROSOFT STORE APP ="
Write-Host "= --------------------------- ="
Write-Host "=   BLACK CONSTRUCTION CORP   ="
Write-Host "==============================="
Write-Host
Write-Host

# PROCESS
# -------
# Install app packages for Microsoft Store App
Write-Host "Installation in progress..."
Write-Host 
Add-AppxPackage "1 - Microsoft.NET.Native.Framework.2.2_2.2.29512.0_x64__8wekyb3d8bbwe.Appx"
Start-Sleep -Seconds 15
Add-AppxPackage "2 - Microsoft.NET.Native.Runtime.2.2_2.2.28604.0_x64__8wekyb3d8bbwe.Appx"
Start-Sleep -Seconds 15
Add-AppxPackage "3 - Microsoft.VCLibs.140.00_14.0.30704.0_x64__8wekyb3d8bbwe.Appx"
Start-Sleep -Seconds 15
Add-AppxPackage "4 - Microsoft.UI.Xaml.2.7_7.2109.13004.0_x64__8wekyb3d8bbwe.Appx"
Start-Sleep -Seconds 15
Add-AppxPackage "5 - Microsoft.WindowsStore_22112.1401.2.0_neutral___8wekyb3d8bbwe.Msixbundle"
Start-Sleep -Seconds 15

# OUTPUT
# ------
# Display to console screen that report has been printed
Write-Host "------------------"
Write-Host "Installation complete."
Write-Host "Good-bye!"
Write-Host
Read-Host “Press ENTER to continue...”

