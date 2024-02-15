# Unix like pwd
if (Test-Path alias:pwd) {
  Remove-Alias -Name pwd
} 
Function pwd { (Get-Location).Path }

# Change to dotfiles directory
if (Test-Path alias:dotfolder) {
  Remove-Alias -Name dotfolder
}
Function dotfolder { Set-Location ~/.local/share/chezmoi }

if (Test-Path alias:dotcommit) {
  Remove-Alias -Name dotcommit
}

Function dotcommit {
  # Export installed apps to file
  . ~/Documents/PowerShell/installed-apps.ps1

  # If no arguments are passed, use the default message
  if ($args.Length -eq 0) {
    $message = "Update dotfiles"
  }
  else {
    $message = $args -join " "
  }
  chezmoi re-add
  chezmoi diff
  chezmoi git -- commit -a -m $message
  chezmoi git -- push
  chezmoi apply
}

# Replace cat with bat
if (Test-Path alias:cat) {
  Remove-Alias -Name cat
}
Set-Alias -Name cat -Value bat

# Replace ls with exa
if (Test-Path alias:ls) {
  Remove-Alias -Name ls
}
Set-Alias -Name ls -Value exa