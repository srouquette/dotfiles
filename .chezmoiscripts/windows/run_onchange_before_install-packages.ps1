# skip package discovery during diff
if ($MyInvocation.Line -contains "diff") {
    exit 0
}
# check if scoop is installed
if (!(Get-Command "scoop" -ErrorAction "Ignore")) {
    Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
    exit 0
}

$buckets = @{
    "extras" = ""
    "okibcn_ScoopMaster" = "https://github.com/okibcn/ScoopMaster"
}

$apps = @{
    "7zip" = "main"
    "aria2" = "main"
    "difftastic" = "main"
    "dotnet-7.0-desktopruntime" = "okibcn_ScoopMaster"
    "irfanview" = "extras"
    "meld" = "extras"
    "paint.net" = "extras"
    "python" = "main"
    "regedix" = "extras"
    "revouninstaller" = "extras"
    "shutup10" = "extras"
    "sysinternals" = "extras"
    "vlc" = "extras"
    "vscode" = "extras"
    "windows-terminal" = "extras"
}

# scoop export will return a json with buckets and apps installed
$export = Invoke-Command -ScriptBlock { scoop export } | ConvertFrom-Json

# filter out existing buckets
$export.buckets | ForEach-Object {
    if ($buckets.ContainsKey($_.Name)) {
        $buckets.Remove($_.Name)
    }
}
# add remaining buckets
$buckets.GetEnumerator() | ForEach-Object {
    if ($_.Value) {
        scoop bucket add $_.Key $_.Value
    } else {
        scoop bucket add $_.Key
    }
}

# filter out installed apps
$export.apps | ForEach-Object {
    if ($apps.ContainsKey($_.Name)) {
        $apps.Remove($_.Name)
    }
}
# install apps
$apps.GetEnumerator() | ForEach-Object {
    scoop install "$($_.Value)/$($_.Key)"
}

if ($buckets.Count -ne 0 -or $apps.Count -ne 0) {
    Write-Host scoop added $buckets.Count new buckets and $apps.Count apps.
}
