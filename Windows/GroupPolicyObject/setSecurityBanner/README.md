# README - Block Removable Storage via CMD

![Title Banner](/Windows/GroupPolicyObject/blockRemovableStorage/media/lgpo_editor_path.png)

### PURPOSE:
The batch file "enableBlockRemovableStorage.bat" is used to harden office computers or laptops that are not managed by a corporate domain network by denying access to all removable storage media. This gives some control for data or files leaking out from a secured or private office location. I had to create this script for our local temporary construction field office that works with the U.S. military as their client who requires various forms of cybersecurity control with our office computers. You may use this script to give some control for your company or personal needs.

### Power Behind the Script - LGPO.exe Tool

![LGPO Help Window](/Windows/GroupPolicyObject/blockRemovableStorage/media/lgpo_console.png)

The LGPO.exe is part of the suite of tools from the Microsoft Security Compliance Toolkit 1.0. It is a new command-line utility to automate the management of local group policy. It replaces the no-longer-maintained LocalGPO tool that shipped with the Security Compliance Manager (SCM), and the Apply_LGPO_Delta and ImportRegPol tools. I use this tool to enable or disable the policy setting "All Removable Storage classes: Deny all access" in the Local Group Policy Editor.

#### Prerequisites:
You will need a Windows Pro version platform which enables Group Policy features to manage your computer.
Be sure to run the batch file "enableBlockRemovableStorage.bat" with Admin rights to make system changes.

#### Target Local Group Policy Editor Path:
Computer Configuration -> Administrative Templates -> System -> Removable Storage Access

#### Policy Setting:
All Removable Storage classes: Deny all access

### CMD Script Window - Screenshots of Code Flow
![Program Window #1](/Windows/GroupPolicyObject/blockRemovableStorage/media/scriptWindow1.png)

![Program Window #2](/Windows/GroupPolicyObject/blockRemovableStorage/media/scriptWindow2.png)

![Program Window #4](/Windows/GroupPolicyObject/blockRemovableStorage/media/scriptWindow4.png)

![Program Window #5](/Windows/GroupPolicyObject/blockRemovableStorage/media/scriptWindow5.png)

![Program Window #3](/Windows/GroupPolicyObject/blockRemovableStorage/media/scriptWindow3.png)

### Reference Links:

#### Microsoft Online Documentation - Microsoft Security Compliance Toolkit 1.0:
https://docs.microsoft.com/en-us/windows/security/threat-protection/security-compliance-toolkit-10

#### LGPO.exe Tool Documentation:
https://techcommunity.microsoft.com/t5/microsoft-security-baselines/lgpo-exe-local-group-policy-object-utility-v1-0/ba-p/701045

#### Download Link - Microsoft Security Compliance Toolkit 1.0 - (with LGPO Tool):
https://www.microsoft.com/en-us/download/details.aspx?id=55319
