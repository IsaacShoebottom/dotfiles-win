function differences($required, $installed) {
	# Args in json format
	# Only compare the names of the software
	# Format is a json array of objects with a name property
	$required_names = $required | ForEach-Object { $_.name }
	$installed_names = $installed | ForEach-Object { $_.name }
	$diff = Compare-Object $required_names $installed_names
	return $diff
}

if (-not (Test-Path "~\scoop\apps.json")) {
	Write-Host "Scoop is installed but the apps.json file is missing"
}
scoop export | Out-File "~\scoop\apps.json"

# Diff the installed software with the required software, if there are differences, install the required software
$required = Get-Content "~\scoop\apps.json" | ConvertFrom-Json
$installed = scoop export | ConvertFrom-Json
$differences = differences $required.apps $installed.apps
if ($differences) {
	Write-Host "The following software not synced:"
	$differences | ForEach-Object { Write-Host $_.InputObject }
	$install = Read-Host "Would you like to install the missing software? (y/n)"
	if ($install -eq "y") {
		# Install the missing software
		scoop import "~\scoop\apps.json"
	}
  else {
		Write-Host "The required software is not installed"
	}
}