# dotfiles

## Windows

```powershell
# install scoop
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression

# then install chezmoi and the dotfiles
scoop install chezmoi
chezmoi init srouquette --apply
```
