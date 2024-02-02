# Test if scoop is installed
if (Get-Command scoop -ErrorAction SilentlyContinue) {
	# Test if .scoop/apps.json exists
	if (Test-Path "$env:USERPROFILE\.scoop\apps.json") {
		# Diff the installed software with the required software, if there are differences, install the required software
		$required = Get-Content "$env:USERPROFILE\.scoop\apps.json" | ConvertFrom-Json
		$installed = scoop export | ConvertFrom-Json
		$differences = differences $required.apps $installed.apps
		if ($differences) {
			Write-Host "The following software is missing:"
			$differences | ForEach-Object { Write-Host $_.InputObject }
			$install = Read-Host "Would you like to install the missing software? (y/n)"
			if ($install -eq "y") {
				# Install the missing software
				scoop import "$env:USERPROFILE\.scoop\apps.json"
			} else {
				Write-Host "The required software is not installed"
				exit 1
			}
		} else {
			Write-Host "All required software is installed"
		}
	} else {
		Write-Host "Scoop is installed but the apps.json file is missing"
		Write-Host "Install chezmoi and get this file from the dotfiles repository"
		$install = Read-Host "Would you like to install chezmoi? (y/n)"
		if ($install -eq "y") {
			# Install chezmoi
			scoop install chezmoi
			# Exit to configure chezmoi
			Write-Host "Run 'chezmoi init {dotfiles_repo}' to configure chezmoi"
			exit 1
		} else {
			Write-Host "The apps.json file is required to install the required software"
			exit 1
		}
		exit 1
	}
} else {
	Write-Host "Scoop is not installed"
	# Prompt user to install scoop
	$install = Read-Host "Would you like to install scoop? (y/n)"
	if ($install -eq "y") {
		# Install scoop
		Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
	} else {
		Write-Host "Scoop is required to install the required software"
		exit 1
	}
}

function differences($required, $installed) {
	# Args in json format
	# Only compare the names of the software
	# Format is a json array of objects with a name property
	$required_names = $required | ForEach-Object { $_.name }
	$installed_names = $installed | ForEach-Object { $_.name }
	$diff = Compare-Object $required_names $installed_names
	return $diff
}