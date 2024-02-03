# Scoop search
Invoke-Expression (&scoop-search --hook)
# Scoop completion
Import-Module "$($(Get-Item $(Get-Command scoop.ps1).Path).Directory.Parent.FullName)\modules\scoop-completion"
# Chezmoi
if (Get-Command chezmoi -ErrorAction SilentlyContinue) { chezmoi completion powershell | Out-String | Invoke-Expression }
# LunarVim
Set-Alias lvim 'C:\Users\Isaac\.local\bin\lvim.ps1'
# Github CLI
Invoke-Expression -Command $(gh completion -s powershell | Out-String)