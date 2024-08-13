# dotfiles

## Windows

### Install

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression

scoop install chezmoi
chezmoi init srouquette --apply
```
