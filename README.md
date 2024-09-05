# dotfiles

## Windows

```powershell
# install scoop
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression

# then install gsudo, chezmoi and the dotfiles
scoop install chezmoi
```

## Linux

#### Arch/Msys2

```bash
pacman -S chezmoi
```

## Install: run chezmoi

```shell
chezmoi init srouquette --apply
```
