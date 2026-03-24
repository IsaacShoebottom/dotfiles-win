### Shell completion

# Scoop completion
Import-Module "$($(Get-Item $(Get-Command scoop.ps1).Path).Directory.Parent.FullName)\modules\scoop-completion"
# Scoop search
if (Get-Command scoop-search -ErrorAction SilentlyContinue) {
	Invoke-Expression (&scoop-search --hook)
}
# gsudo
if (Get-Command gsudo -ErrorAction SilentlyContinue) {
	Import-Module gsudoModule
}
# Chezmoi
if (Get-Command chezmoi -ErrorAction SilentlyContinue) {
	Invoke-Expression ((&chezmoi completion powershell | Out-String))
}
# Github CLI
if (Get-Command gh -ErrorAction SilentlyContinue) {
	Invoke-Expression ((&gh completion -s powershell | Out-String))
}
# zoxide
if (Get-Command zoxide -ErrorAction SilentlyContinue) {
	Invoke-Expression ((&zoxide init powershell | Out-String))
}
# packwiz
if (Get-Command packwiz -ErrorAction SilentlyContinue) {
	Invoke-Expression ((&packwiz completion powershell | Out-String))
}

### Aliases

# Unix like pwd
if (Test-Path alias:pwd) {
  Remove-Alias -Name pwd
}
Function pwd { (Get-Location).Path }

# Chezmoi
if (Get-Command chezmoi -ErrorAction SilentlyContinue) {
	Function .add {
		if ($args[0] -eq $null -and $args[1] -eq $null) {
			Write-Host "Usage: .add <file> <message>"
			return
		}
		chezmoi add "$args[0]"
		chezmoi add .
		chezmoi git status
		$answer = Read-Host "Commit changes? [y/N]"
		if ($answer -eq "y" -or $answer -eq "Y") {
			chezmoi git -- commit -m "$args[1]"
			$answer = Read-Host "Push changes? [y/N]"
			if ($answer -eq "y" -or $answer -eq "Y") {
				chezmoi git push
			}
		}
	}
	Function .re-add {
		if ($args[0] -eq $null){
			Write-Host "Usage: .re-add <message>"
			return
		}
		chezmoi re-add
		chezmoi git status
		chezmoi git diff
		$answer = Read-Host "Commit changes? [y/N]"
		if ($answer -eq "y" -or $answer -eq "Y") {
			chezmoi git -- commit -am `$args[0]`
			$answer = Read-Host "Push changes? [y/N]"
			if ($answer -eq "y" -or $answer -eq "Y") {
				chezmoi git push
			}
		}
	}
	Function .push { chezmoi git push }
	Function .pull { chezmoi git pull }
	Function .status { chezmoi git status }
	Function .diff { chezmoi git diff }
	Function .update { chezmoi update }
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

# Replace cd with zoxide
if (Test-Path alias:cd) {
  Remove-Alias -Name cd
}
Set-Alias -Name cd -Value z

# Replace grep with ugrep
if (Test-Path alias:grep) {
  Remove-Alias -Name grep
}
Set-Alias -Name grep -Value ugrep

# Add alias for recycle-bin
if (Test-Path alias:rb) {
  Remove-Alias -Name rb
}
Set-Alias -Name rb -Value recycle-bin

# Add alias for sudo
if (Test-Path alias:sudo) {
  Remove-Alias -Name sudo
}
Set-Alias -Name sudo -Value gsudo

# Add alias to re-source profile
if (Test-Path alias:rc) {
  Remove-Alias -Name rc
}
Function rc { . $profile }

# Add shorthand alias for scoop update and cleanup
Function update {
	# Update all scoop apps, clean up old versions, and clear the cache
	gsudo scoop update *
	gsudo scoop cleanup *
	gsudo scoop cache rm *
	# Update windows
	UsoClient /StartScan
	UsoClient /StartDownload
	UsoClient /StartInstall
}
# Switch to default dir if inside the scoop windows terminal app directory
if ((Get-Location) -like "*scoop\apps\windows-terminal*") {
    Set-Location ~
}
