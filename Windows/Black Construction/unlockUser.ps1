Import-Module ActiveDirectory

# Prompt for the AD username
$username = Read-Host "Enter Active Directory username"

try {
    # Retrieve the user and account status
    $user = Get-ADUser -Identity $username `
        -Properties LockedOut, Enabled, PasswordExpired, LastLogonDate `
        -ErrorAction Stop

    # Display account information
    Write-Host "`nActive Directory User Status" -ForegroundColor Cyan
    Write-Host "----------------------------"
    Write-Host "Name             : $($user.Name)"
    Write-Host "Username         : $($user.SamAccountName)"
    Write-Host "Enabled          : $($user.Enabled)"
    Write-Host "Locked Out       : $($user.LockedOut)"
    Write-Host "Password Expired : $($user.PasswordExpired)"
    Write-Host "Last Logon       : $($user.LastLogonDate)"

    # Only prompt for unlock if the account is locked
    if ($user.LockedOut) {

        Write-Host "`nAccount is currently LOCKED." -ForegroundColor Red

        $response = Read-Host "Do you want to unlock this account? (Y/N)"

        if ($response -match '^[Yy]$') {

            try {
                Unlock-ADAccount -Identity $user -ErrorAction Stop

                # Verify the account status after unlocking
                $updatedUser = Get-ADUser -Identity $username `
                    -Properties LockedOut

                if (-not $updatedUser.LockedOut) {
                    Write-Host "`nSUCCESS: $username has been unlocked." -ForegroundColor Green
                }
                else {
                    Write-Host "`nWARNING: The account still reports as locked." -ForegroundColor Yellow
                }
            }
            catch {
                Write-Host "`nERROR: Unable to unlock the account." -ForegroundColor Red
                Write-Host $_.Exception.Message -ForegroundColor Red
            }
        }
        else {
            Write-Host "`nNo changes were made." -ForegroundColor Yellow
        }
    }
    else {
        Write-Host "`nAccount is not locked. No action is required." -ForegroundColor Green
    }
}
catch {
    Write-Host "`nERROR: Unable to locate '$username' in Active Directory." -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
}
