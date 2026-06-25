[CmdletBinding()]
param (
    [Parameter(Mandatory = $false)]
    [string]$SecretKey,

    [int]$Digits = 6,
    [int]$Period = 30
)

# 1. Prompt the user for the key if it wasn't passed as a parameter
if ([string]::IsNullOrWhiteSpace($SecretKey)) {
    # Read-Host with -AsSecureString masks the input with asterisks (*) for safety
    $SecurePrompt = Read-Host -Prompt "Enter your MFA Secret Key" -AsSecureString
    
    # Convert the secure string back to plain text so the algorithm can process it
    $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecurePrompt)
    $SecretKey = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
}

# 2. Clean the secret key and pad it for Base32 decoding
$Base32Chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ234567"
$CleanSecret = $SecretKey.ToUpper().Replace(" ", "")

$PaddingCount = (8 - ($CleanSecret.Length % 8)) % 8
$CleanSecret += "=" * $PaddingCount

# 3. Decode the Base32 Secret Key into a Byte Array
$SecretBytes = [System.Collections.Generic.List[byte]]::new()
$Buffer = 0
$BitsLeft = 0

foreach ($Char in $CleanSecret.ToCharArray()) {
    if ($Char -eq '=') { break }
    $Value = $Base32Chars.IndexOf($Char)
    if ($Value -lt 0) { throw "Invalid character in Base32 secret key." }

    $Buffer = ($Buffer -shl 5) -bor $Value
    $BitsLeft += 5

    if ($BitsLeft -ge 8) {
        $BitsLeft -= 8
        $SecretBytes.Add([byte](($Buffer -shr $BitsLeft) -band 255))
    }
}

# 4. Calculate the current time step interval (RFC 6238)
$UnixEpoch = [DateTimeOffset]::FromUnixTimeSeconds(0)
$CurrentTime = [DateTimeOffset]::UtcNow
$SecondsSinceEpoch = [long]($CurrentTime - $UnixEpoch).TotalSeconds
$TimeStep = [long]($SecondsSinceEpoch / $Period)

# Convert the Time Step into an 8-byte big-endian array
$TimeStepBytes = [BitConverter]::GetBytes($TimeStep)
if ([BitConverter]::IsLittleEndian) {
    [Array]::Reverse($TimeStepBytes)
}

# 5. Generate the HMAC-SHA1 Hash using the secret key
$Hmac = [System.Security.Cryptography.HMACSHA1]::new($SecretBytes.ToArray())
$Hash = $Hmac.ComputeHash($TimeStepBytes)

# 6. Dynamic Truncation to extract the 4-byte code
$Offset = $Hash[-1] -band 0x0F
$BinaryCode = (($Hash[$Offset] -band 0x7F) -shl 24) -bor
               (($Hash[$Offset + 1] -band 0xFF) -shl 16) -bor
               (($Hash[$Offset + 2] -band 0xFF) -shl 8) -bor
               ($Hash[$Offset + 3] -band 0xFF)

# 7. Format the final output to the requested length
$Modulus = [Math]::Pow(10, $Digits)
$MfaCode = $BinaryCode % $Modulus
$FinalCode = $MfaCode.ToString().PadLeft($Digits, '0')

# Output the results neatly
Write-Host ""
Write-Host "------------------------------------" -ForegroundColor Gray
Write-Host "Your current MFA Code is: " -NoNewline
Write-Host $FinalCode -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Gray