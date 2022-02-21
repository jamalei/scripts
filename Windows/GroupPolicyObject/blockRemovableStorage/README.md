# README - Block Removable Storage via CMD

![Title Banner](/Windows/GroupPolicyObject/blockRemovableStorage/media/lgpo_editor_path.png)

### PURPOSE:
The CMD script "enableBlockRemovableStorage.bat" is used to hardened office computers or laptops that are not managed by a corporate domain network by denying access to all removable storage media. This gives some control for data or files leaking out from a secured or private office location. I had to create this script for our local temporary construction field office that works with the U.S. military as their client who requires various forms of cybersecurity control with our office computers. You may use this script to give some control for your company or personal needs.

#### Important Note:
Be sure to run CMD script "enableBlockRemovableStorage.bat" with Admin rights to make system changes.

#### Target Local Group Policy Editor Path:
Computer Configuration -> Administrative Templates -> System -> Removable Storage Access

#### Policy Setting:
All Removable Storage classes: Deny all access

#### CMD Script Window - Screenshots of Code Flow
![Program Window #1](/Windows/GroupPolicyObject/blockRemovableStorage/media/scriptWindow1.png)

![Program Window #2](/Windows/GroupPolicyObject/blockRemovableStorage/media/scriptWindow2.png)

![Program Window #3](/Windows/GroupPolicyObject/blockRemovableStorage/media/scriptWindow3.png)

![Program Window #4](/Windows/GroupPolicyObject/blockRemovableStorage/media/scriptWindow4.png)

![Program Window #5](/Windows/GroupPolicyObject/blockRemovableStorage/media/scriptWindow5.png)


#### LGPO Tool Console Window
![LGPO Help Window](/Windows/GroupPolicyObject/blockRemovableStorage/media/lgpo_console.png)

### Reference Links:

#### Microsoft Online Documentation - Microsoft Security Compliance Toolkit 1.0:
https://docs.microsoft.com/en-us/windows/security/threat-protection/security-compliance-toolkit-10

#### LGPO.exe Tool Documentation:
https://techcommunity.microsoft.com/t5/microsoft-security-baselines/lgpo-exe-local-group-policy-object-utility-v1-0/ba-p/701045

#### Download Link - Microsoft Security Compliance Toolkit 1.0 - (with LGPO Tool):
https://www.microsoft.com/en-us/download/details.aspx?id=55319
