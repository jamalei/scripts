# Re-install Essential Windows Apps for a New Workstation
$apps = @(
    "7zip.7zip",
    "Adobe.Acrobat.Reader.64-bit",
    "Google.Chrome",
    "Notepad++.Notepad++",
    "Microsoft.WindowsTerminal",
    "Microsoft.PowerShell",
    "Microsoft.VisualStudioCode",
    "Vim.Vim"
)

foreach ($app in $apps) {
    winget install --id $app -e --silent --accept-package-agreements --accept-source-agreements
}
