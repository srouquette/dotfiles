{{ $cmd := joinPath .chezmoi.homeDir "scoop" "shims" "arch.exe" }}

{{ $script := joinPath .chezmoi.sourceDir ".internals" "wsl" "setup_as_root.sh" }}
Invoke-Command -ScriptBlock { {{ $cmd }} runp {{ $script }} {{ .username }} }

Invoke-Command -ScriptBlock { {{ $cmd }} config --append-path false }
Invoke-Command -ScriptBlock { {{ $cmd }} config --default-user {{ .username }} }

{{ $script := joinPath .chezmoi.sourceDir ".internals" "wsl" "setup_as_user.sh" }}
Invoke-Command -ScriptBlock { {{ $cmd }} runp {{ $script }} }
