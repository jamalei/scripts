param(
    [int]$Length = 12,
    [switch]$Uppercase,
    [switch]$Lowercase,
    [switch]$Numbers,
    [switch]$Symbols
)

# Character sets
$upperChars   = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
$lowerChars   = "abcdefghijklmnopqrstuvwxyz"
$numberChars  = "0123456789"
$symbolChars  = "!@#$%^&*()-_=+[]{}|;:,.<>?/"

# Build character pool
$charPool = ""

if ($Uppercase) { $charPool += $upperChars }
if ($Lowercase) { $charPool += $lowerChars }
if ($Numbers)   { $charPool += $numberChars }
if ($Symbols)   { $charPool += $symbolChars }

# Validate at least one option
if ($charPool.Length -eq 0) {
    Write-Error "You must select at least one character type (Uppercase, Lowercase, Numbers, Symbols)."
    exit
}

# Secure random generator
$rng = [System.Security.Cryptography.RandomNumberGenerator]::Create()
$bytes = New-Object byte[] ($Length)
$rng.GetBytes($bytes)

# Build password
$password = ""
for ($i = 0; $i -lt $Length; $i++) {
    $index = $bytes[$i] % $charPool.Length
    $password += $charPool[$index]
}

# Output
Write-Output "Generated Password: $password"