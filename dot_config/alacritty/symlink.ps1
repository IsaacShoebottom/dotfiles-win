if (Test-Path "$env:APPDATA\alacritty\alacritty.toml") {
	Remove-Item -Path "$env:APPDATA\alacritty\alacritty.toml"
}
if (Test-Path "$env:APPDATA\alacritty") {
	Remove-Item -Path "$env:APPDATA\alacritty" -Recurse
}
New-Item -ItemType Directory -Path "$env:APPDATA\alacritty"
New-Item -ItemType SymbolicLink -Path "$env:APPDATA\alacritty\alacritty.toml" -Value "$PSScriptRoot\alacritty.toml"