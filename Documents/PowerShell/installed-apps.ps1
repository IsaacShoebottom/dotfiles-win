function sortScoopOutput($scoop) {
    $ht = ConvertFrom-Json -AsHashtable -InputObject $scoop
    $od = [ordered]@{}
    # Structure of json is object with a key name and the value as an array of objects, which each have 4 key value pairs
    # Sort the keys and the array of objects, as well the key value pairs in the objects
    foreach ($key in $ht.Keys | Sort-Object) {
        $od[$key] = @()
        foreach ($app in $ht[$key] | Sort-Object) {
            $app = $app | Sort-Object
            $od[$key] += [ordered]@{}
            foreach ($k in $app.Keys | Sort-Object) {
                $od[$key][-1][$k] = $app[$k]
            }
        }
        # Sort the array by the name key 
        # NOTE: This property is hard coded, and could be changed if scoop changes the json structure
        $od[$key] = $od[$key] | Sort-Object -Property name
    }
    $json = ConvertTo-Json -InputObject $od
    $json_string = $json -join "`n"
    return $json_string
}

# Scoop installed apps
# sortScoopOutput($(scoop export)) | Out-File "~\scoop\apps.json"
scoop export | Out-File "~\scoop\apps.json"
# Pipx installed apps
pipx list --json | Out-File "~\.pipx.json"