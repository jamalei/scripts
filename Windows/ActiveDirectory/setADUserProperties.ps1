# Program Title: setADUserProperties.ps1
# Last Updated By: 07/29/2021 - BCC - Joey S. Amalei
# Purpose: Reads a CSV file and then sets the comment properties of AD Users
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
# Read in the CSV file with list of users and AB numbers
$UsersCSV = Import-CSV ".\bcc_employees_data.csv"
$Results = @()

ForEach ($User in $UsersCSV)
{
    $Username = $User.FirstName + "*" + $User.LastName
    $Comment = $User.Comment
    $UserCheck = $null
    $ErrorLog = $null

    # Verify if user is on AD
    try
    {
        $UserCheck = Get-ADUser -Filter{displayName -like $Username} -Properties SamAccountName, Comment -ErrorAction SilentlyContinue
        if ($UserCheck -ne $null)
        {
            # Set AB number comment property to AD User
            Set-ADUser -Identity $UserCheck.SamAccountName -replace @{'comment' = $($Comment)}

            # Build CSV listing of all AD Users processed
            $Object = New-Object PSObject -Property @{
                "User Name" = $User.FirstName + " " + $User.LastName
                "Comment" = $UserCheck.comment
            }

            # Append listing
            $Results += $Object
        }
        else
        {
            # Collect and Log Users not found on the AD
            $ErrorLog += $User.FirstName + " " + $User.LastName + "," + $Comment
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
       Add-Content ".\errorLog.txt" $ErrorLog 
    }
}

# Generate CSV file of AD Users Processed
$Results | Export-CSV ".\Results.csv"


# OUTPUT
# ------
# Display to console screen that report has been printed
Write-Host
Write-Host
Write-Host "------------------"
Write-Host
Write-Host "Process completed. Results and Error Log generated."
Write-Host "Good-bye!"