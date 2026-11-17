# Title: showAccountStatus
# Last Updated By: 11/17/2026 - JSA
# Purpose:
#    Show Active Directory user's account status


# Import needed libraries
# Import-Module ActiveDirectory

# Output screen title
Clear-Host
Write-Host "------------------------"
Write-Host "SHOW USER ACCOUNT STATUS" -ForegroundColor Cyan
Write-Host "------------------------"
Write-Host

# Prompt for the AD username
$username = Read-Host "Enter Username"
$domainControllers = Read-Host "Enter domain controller server name"
$DaysBack = Read-Host "Enter number of days to search history logs"

try {
    # Retrieve the user and account status
    $user = Get-ADUser -Identity $username `
        -Properties LockedOut, Enabled, PasswordExpired, LastLogonDate `
        -ErrorAction Stop

    # Use the authoritative SamAccountName returned by Active Directory
    $samAccountName = $user.SamAccountName

    # Display account information
    Write-Host "`nActive Directory User Status" -ForegroundColor Cyan
    Write-Host "-----------------------------"
    Write-Host "Name              : $($user.Name)"
    Write-Host "Username          : $samAccountName"
    Write-Host "Enabled?          : $($user.Enabled)"
    Write-Host "Locked Out?       : $($user.LockedOut)"
    Write-Host "Password Expired? : $($user.PasswordExpired)"
    Write-Host "Last Logon        : $($user.LastLogonDate)"

    # ---------------------------------------------------------
    # Search domain controller Security logs for disable events
    # Event ID 4725: A user account was disabled
    # ---------------------------------------------------------

    Write-Host "`nSearching domain controller audit logs for account disable events..." `
        -ForegroundColor Cyan

    $startTime = (Get-Date).AddDays(-$DaysBack)

    # Query all Active Directory domain controllers because the event
    # is normally recorded on the DC that processed the disable action.
    
    # Uncomment allow search of all domain controllers in environment
    # $domainControllers = Get-ADDomainController -Filter * |
    #    Select-Object -ExpandProperty HostName

    $disableEvents = foreach ($domainController in $domainControllers) {

        Write-Host "Checking $domainController..." -ForegroundColor DarkGray

        try {
            $events = Get-WinEvent `
                -ComputerName $domainController `
                -FilterHashtable @{
                    LogName   = "Security"
                    Id        = 4725
                    StartTime = $startTime
                } `
                -ErrorAction Stop

            foreach ($incident in $events) {

                # Convert the event to XML so individual audit fields
                # can be read reliably by their field names.
                [xml]$eventXml = $incident.ToXml()

                $eventData = @{}

                foreach ($dataItem in $eventXml.Event.EventData.Data) {
                    $eventData[$dataItem.Name] = $dataItem.'#text'
                }

                # TargetUserName corresponds to the disabled account.
                if ($eventData["TargetUserName"] -ieq $samAccountName) {

                    [PSCustomObject]@{
                        DisabledAccount = $eventData["TargetUserName"]
                        DisabledBy      = $eventData["SubjectUserName"]
                        DisabledByDomain = $eventData["SubjectDomainName"]
                        DisabledDate    = $incident.TimeCreated
                        TargetDomain    = $eventData["TargetDomainName"]
                        DomainController = $incident.MachineName
                        EventRecordId   = $incident.RecordId
                    }
                }
            }
        }
        catch {
            Write-Warning "Unable to query Security logs on $domainController. $($_.Exception.Message)"
        }
    }

    # Display matching account-disable events
    Write-Host "`nAccount Disable Audit Review" -ForegroundColor Cyan
    Write-Host "-----------------------------"

    if ($disableEvents) {
        # Display the newest matching event
        $latestDisableEvent = $disableEvents |
            Select-Object -First 1

        Write-Host "`nMost Recent Disable Event" -ForegroundColor Yellow
        Write-Host "Disabled Account : $($latestDisableEvent.DisabledAccount)"
        Write-Host "Disabled By      : $($latestDisableEvent.DisabledByDomain)\$($latestDisableEvent.DisabledBy)"
        Write-Host "Disabled Date    : $($latestDisableEvent.DisabledDate)"
        Write-Host "Domain Controller: $($latestDisableEvent.DomainController)"
    }
    else {
        Write-Host "No Event ID 4725 records were found for '$samAccountName' within the last $DaysBack days." `
            -ForegroundColor Yellow
    }
}
catch [Microsoft.ActiveDirectory.Management.ADIdentityNotFoundException] {
    Write-Host "`nERROR: Active Directory user '$username' was not found." `
        -ForegroundColor Red
}
catch {
    Write-Host "`nERROR: The operation could not be completed." `
        -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
}
