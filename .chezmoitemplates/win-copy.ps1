
$srcfile = {{ .src | quote }}
$dstfile = {{ .dst | quote }}
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
} else {
    # Skip if application has not been installed.
    if (!($dstfile |Split-Path)) {
        exit 0
    }
}

# Copy source file to destination.
xcopy /fvy $srcfile "$dstfile*"
