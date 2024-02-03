# Unix like pwd
if (Test-Path alias:pwd) {
    Remove-Alias -Name pwd
  } 
  Function pwd {(Get-Location).Path}

  # Change to dotfiles directory
  if (Test-Path alias:dotfolder) {
    Remove-Alias -Name dotfolder
  }
  function dotfolder {Set-Location ~/.local/share/chezmoi}