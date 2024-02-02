# Chezmoi
if (Get-Command chezmoi -ErrorAction SilentlyContinue) { chezmoi completion powershell | Out-String | Invoke-Expression }