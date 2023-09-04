# установка
- https://www.youtube.com/watch?v=oPymb2-IXbg
- https://nixos.org/manual/nixos/stable/index.html#sec-installation

# install package

```bash
nix-channel --add https://nixos.org/channels/nixpkgs-unstable
# найти пакет
nix-env -qa 'neovim*'
# установить пакет
nix-env -i neovim
# удалить
nix-env -e neovim
# обновить
nix-env -u neovim
nix-env -i --dry-run neovim
```


# youtube

- Грязный способо с pip
- https://www.youtube.com/watch?v=USDbjmxEZ_I&ab_channel=Enthought
- чувак показывает как он работает на пакетами nixos `nixpkgs-review wip`
- https://www.youtube.com/watch?v=D_IZ2EfW_8U&ab_channel=JonRinger
- собирает OpenRGB nix-template
- https://www.youtube.com/watch?v=bkDYmvKINm8&ab_channel=JonRinger
- python310Pacage build 
- https://www.youtube.com/watch?v=jXd-hkP4xnU&t=253s&ab_channel=JonRinger
- чувак компилит пакеты
- https://www.youtube.com/watch?v=uATCXO6NSoU&ab_channel=ChrisMcDonough

# command

```
# собрать deb пакет со всеми зависимостями
nix bundle --bundler bundlers#toDEB nixpkgs#hello
```
