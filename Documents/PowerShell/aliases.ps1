# Unix like pwd
if (Test-Path alias:pwd) {
    Remove-Alias -Name pwd
  } 
  Function pwd {(Get-Location).Path}