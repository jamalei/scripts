@echo off
rem Formats title window and console window color attributes (0 - black background / 2 - green foreground)
Title enableBlockRemovableStorage
color 02

rem Enables menu character boarders in print screen
chcp 65001
rem Set current working directory to location of this script file
set location=%~dp0

rem
rem enableBlockRemovableStorage.bat
rem LAST UPDATED BY: 02/18/2022 - Joey S. Amalei
rem PURPOSE: Enable Windows platform registry and local GPO to deny access
rem          to all removable storage media (USB flash drives, DVD/CD Drives, etc.)
rem KNOWN ISSUES: User input is not flexible to accept both upper case and lower case answers of (y/n)
rem               Any unmatching inputs will execute code block
rem
rem SPECIAL NOTES:
rem This script uses the Microsoft's Local Group Policy Object Utility (LGPO.exe) version 3.0
rem For more details, please refer to Microsoft's webpage and the PDF file included with this script.
cls
echo ╔════════════════════════════════╗
echo ║ enableBlockRemovableStorage    ║
echo ╠════════════════════════════════╣
echo ║ Author: JSA (Feb 2022)         ║
echo ╚════════════════════════════════╝
echo.
echo.
rem ======
rem INPUT:
rem ======
rem Request user if they want to block all removable storage media
set /p userDecisionToBlock=Would you like to block all removable storage media? (y/n):

rem ========
rem PROCESS:
rem ========
rem Process user input decision tree
if "%userDecisionToBlock%"=="n" goto UNBLOCK
	
	rem Enable block to all removable storage media
	start /D %location% LGPO.exe /r regpol_block.txt /w C:\WINDOWS\System32\GroupPolicy\Machine\Registry.pol
	gpupdate /force	
	
	goto END
:UNBLOCK
	rem Request user if they want to unblock all removable storage media
	set /p userDecisionToEnd=Would you like to unblock all removable storage media? (y/n):
	
	rem Process user input decision tree
	if "%userDecisionToEnd%"=="n" goto END
	
	rem Unblock all removable storage media
	start /D %location% LGPO.exe /r regpol_unblock.txt /w C:\WINDOWS\System32\GroupPolicy\Machine\Registry.pol
	gpupdate /force
	
	goto END
:END
rem =======
rem OUTPUT:
rem =======
rem Print output message and terminate program
cls
echo ╔══════════════════╗
echo ║ PROGRAM COMPLETE ║
echo ╚══════════════════╝
echo.
echo.
echo Thank you! Your request has been completed! Closing program...
pause