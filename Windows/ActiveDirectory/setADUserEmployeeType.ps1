# Program Title: setADEmployeeType.ps1
# Last Updated By: 08/22/2026 - BCC - Joey S. Amalei
# Purpose: Reads a CSV file and then sets the EmployeeType properties of AD Users
#

# Import needed modules
Import-Module ActiveDirectory

# Clear console screen
Clear-Host

Write-Host "============================="
Write-Host "= SET USER PROPERTIES       ="
Write-Host "= ------------------------- ="
Write-Host "=   BLACK CONSTRUCTION CORP ="
Write-Host "============================="
Write-Host
Write-Host
Write-Host "Processing user listing... One moment..."

# INPUT
# Read in the CSV file with list of users and Employee Types
$UsersCSV = Import-CSV ".\employees_data.csv"
$Results = @()

ForEach ($User in $UsersCSV)
{
    $Username = $User.Username
    $EmployeeType = $User.EmployeeType
    $UserCheck = $null
    $ErrorLog = $null

    # Verify if user is on AD
    try
    {
        $UserCheck = Get-ADUser -Filter{SAMAccountName -like $Username} -Properties SAMAccountName, EmployeeType -ErrorAction SilentlyContinue
        if ($UserCheck -ne $null)
        {
            # Set EmployeeType property to AD User
            Set-ADUser -Identity $UserCheck.SamAccountName -replace @{'employeeType' = $($EmployeeType)}

            # Build CSV listing of all AD Users processed
            $Object = New-Object PSObject -Property @{
                "User Name" = $UserCheck.SAMAccountName
                "Employee Type" = $User.EmployeeType
            }

            # Append listing
            $Results += $Object
        }
        else
        {
            # Collect and Log Users not found on the AD
            $ErrorLog += $User.Username + "," + $User.EmployeeType
        }
    }
    catch
    {
        # Collect and Log any other errors
        $ErrorLog += $_.Exception.Message
        Continue
    }
    finally
    {
       # Append error message onto log text file
       Add-Content -Path (Join-Path $PSScriptRoot ".\errorLog.txt") -Value $ErrorLog
    }
}

# Generate CSV file of AD Users Processed
$Results | Export-CSV ".\results_user_employee_type.csv"


# OUTPUT
# ------
# Display to console screen that report has been printed
Write-Host
Write-Host "------------------"
Write-Host
Write-Host "Process completed. Results and Error Log generated."
Write-Host "Good-bye!"
