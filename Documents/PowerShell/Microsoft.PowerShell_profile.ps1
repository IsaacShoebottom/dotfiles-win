# Sync apps with scoop
# . ~/Documents/PowerShell/verify-state.ps1
scoop export | Out-File "~\scoop\apps.json"

# Shell completion
. ~/Documents/PowerShell/completions.ps1

# Aliases
. ~/Documents/PowerShell/aliases.ps1