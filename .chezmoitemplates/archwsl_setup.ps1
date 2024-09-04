{{ $cmd := joinPath .chezmoi.homeDir "scoop" "shims" "arch.exe" }}
{{ $script_root := joinPath .chezmoi.sourceDir ".internals" "wsl" "setup_as_root.sh" }}
{{ $script_user := joinPath .chezmoi.sourceDir ".internals" "wsl" "setup_as_user.sh" }}

Invoke-Command -ScriptBlock { {{ $cmd }} runp {{ $script_root }} $Env:USERNAME }
Invoke-Command -ScriptBlock { {{ $cmd }} config --append-path false }
Invoke-Command -ScriptBlock { {{ $cmd }} config --default-user $Env:USERNAME }
Invoke-Command -ScriptBlock { {{ $cmd }} runp {{ $script_user }} $Env:USERNAME }
