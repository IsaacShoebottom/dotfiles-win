# Sync apps with scoop
# . ~/Documents/PowerShell/verify-state.ps1
# . ~/Documents/PowerShell/installed-apps.ps1

# Shell completion
. ~/Documents/PowerShell/completions.ps1

# Aliases
. ~/Documents/PowerShell/aliases.ps1

# Switch to default dir
if ((Get-Location) -like "*scoop\apps\windows-terminal*") {
    Set-Location ~
}