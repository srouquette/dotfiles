function Copy-File {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$srcfile,

        [Parameter(Mandatory)]
        [string]$dstfile
    )

    $dstitem = Get-Item $dstfile -ErrorAction SilentlyContinue
    if ($null -ne $dstitem) {
        # Skip if destination is a symbolic link.
        $type = $dstitem.LinkType
        if ($type -eq "HardLink" -or $type -eq "SymbolicLink") {
            exit 0
        }

        # Skip if configuration files are identical.
        if ($(Get-FileHash $srcfile).Hash -eq $(Get-FileHash $dstfile).Hash) {
            exit 0
        }
    }
    else {
        # Check the parent directory and skip if application has not been installed.
        if (!($dstfile | Split-Path)) {
            exit 0
        }
    }

    # Copy source file to destination.
    xcopy /fvy "$srcfile" "$dstfile*"
}

# Run Windows Terminal in Quake Mode on startup
Copy-File   "$Env:CHEZMOI_SOURCE_DIR/internals/Windows/Startup/Quake Terminal.lnk" `
            "$Env:USERPROFILE/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup/Quake Terminal.lnk"
