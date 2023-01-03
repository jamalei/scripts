# README - Set Security Logon Banner Text

![Title Banner #1](/Windows/GroupPolicyObject/setSecurityBanner/media/regedit_entry.jpg)
![Title Banner #2](/Windows/GroupPolicyObject/blockRemovableStorage/media/group_policy_entry2.png)

### PURPOSE:
The PowerShell script file "setSecurityBanner.ps1" was used to help apply my company's security logon banner via Windows Registry Editor. This script was needed as we had to prepare our computers in our office environment to be compliant following Cybersecurity Maturity Model Certification (CMMC) and NIST 800-171 standards.

#### Prerequisites:
You will need a Windows Pro version platform which enables Group Policy features to manage your computer.
Be sure to run the Windows PowerShell script file "setSecurityBanner.ps1" with Admin rights to make system changes.

#### Target Windows Registry Editor Path:
HKLM - \SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System

#### Target Local Group Policy Editor Path:
Computer Configuration -> Windows Settings -> Security Options

### Windows PowerShell Script Window - Screenshots of Code Flow
![Program Window #1](/Windows/GroupPolicyObject/setSecurityBanner/media/screen_1.png)

![Program Window #2](/Windows/GroupPolicyObject/setSecurityBanner/media/screen_2_yes.png)

![Program Window #3](/Windows/GroupPolicyObject/setSecurityBanner/media/screen_2_no.png)


### Reference Links:

#### How to Change Registry Entries Using PowerShell
https://www.thewindowsclub.com/change-registry-using-windows-powershell

#### Microsoft Documentation API - PowerShell - IF statement blocks
https://learn.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-if?view=powershell-7.3
